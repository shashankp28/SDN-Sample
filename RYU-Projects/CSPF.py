"""
Centralized Shortest Path First (CFSP) Controller
"""
from collections import deque 
from ryu.base import app_manager
from ryu.ofproto import ofproto_v1_4, ether
from ryu.controller.handler import set_ev_cls, CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller import ofp_event
from ryu.topology import api as topology
from ryu.lib.packet import packet, ethernet
from ryu.topology.event import EventHostAdd, EventHostDelete, EventLinkAdd, EventLinkDelete


class Graph:
    
    def __init__(self):
        self.neighbours = dict()
        self.port_map = dict()
        self.host_switch_map = dict()
        self.shortest_paths = dict()
        self.switch_host_map = dict()
        self.datapath_map = dict()
    
    def add_node(self, node):
        self.neighbours[node] = set()
        self.switch_host_map[node] = set()
    
    def add_datapath(self, dpid, datapath):
        self.datapath_map[dpid] = datapath
    
    def add_link(self, link):
        src_switch = link.src.dpid
        dst_switch = link.dst.dpid
        src_port = link.src.port_no
        self.neighbours[src_switch].add(dst_switch)
        self.port_map[(src_switch, dst_switch)] = src_port

    def add_host(self, host, switch, port):
        self.host_switch_map[host] = (switch, port)
        self.switch_host_map[switch].add(host)

    def remove_node(self, node):
        self.neighbours.pop(node)
        for neighbour in self.neighbours:
            self.neighbours[neighbour].remove(node)
        for link in self.port_map:
            if link[0] == node or link[1] == node:
                self.port_map.pop(link)
        for host in self.host_switch_map:
            if self.host_switch_map[host][0] == node:
                self.host_switch_map.pop(host)
        self.switch_host_map.pop(node)
        self.datapath_map.pop(node)

    def remove_link(self, link):
        src_switch = link.src.dpid
        dst_switch = link.dst.dpid
        self.neighbours[src_switch].remove(dst_switch)
        self.port_map.pop((src_switch, dst_switch))

    def remove_host(self, host):
        switch = self.host_switch_map[host][0]
        self.switch_host_map[switch].remove(host)
        self.host_switch_map.pop(host)
        
    def compute_shortest_paths(self):
        """
        Computes shortest paths between all pairs of hosts.
        Uses BFS to find shortest paths.
        BFS is applied for every host in the network.
        """
        self.shortest_paths = dict()
        for host in self.host_switch_map:
            root_switch = self.host_switch_map[host][0]
            visited = set()
            queue = deque()
            queue.append(root_switch)
            visited.add(root_switch)
            if host not in self.shortest_paths:
                self.shortest_paths[host] = dict()
            self.shortest_paths[host][root_switch] = root_switch
            while queue:
                current_switch = queue.popleft()
                for neighbour in self.neighbours[current_switch]:
                    if neighbour not in visited:
                        queue.append(neighbour)
                        visited.add(neighbour)
                        self.shortest_paths[host][neighbour] = current_switch
    
    def get_next_port(self, switch1, switch2, host):
        if switch1 == switch2:
            return self.host_switch_map[host][1]
        return self.port_map[(switch1, switch2)]
    
    def get_next_hop(self, dst_mac, switch):
        if (dst_mac in self.shortest_paths) and \
                (switch in self.shortest_paths[dst_mac]):
            return self.shortest_paths[dst_mac][switch]
        return None

    def print_graph(self):
        print("<--------------- Graph --------------->")
        print("Switch Connections:", self.neighbours)
        print("Switch-Switch Mapping", self.port_map)
        print("Host-Switch Mapping:", self.host_switch_map)
        print("Switch-Host Mapping:", self.switch_host_map)
        print("Shortest Paths:", self.shortest_paths)
        print("<-------------------------------------->")

class CSFP(app_manager.RyuApp):

    OFP_VERSIONS = [ofproto_v1_4.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(CSFP, self).__init__(*args, **kwargs)
        self.LOW = 10
        self.MEDIUM = 20
        self.HIGH = 30
        self.ULTRA = 40
        self.network = Graph()


    def add_flow(self, datapath, priority, match, actions, buffer_id=None):
        instructions = [
            datapath.ofproto_parser.OFPInstructionActions(
                datapath.ofproto.OFPIT_APPLY_ACTIONS,
                actions,
            )
        ]
        if not buffer_id:
            modification = datapath.ofproto_parser.OFPFlowMod(
                datapath=datapath,
                priority=priority,
                match=match,
                instructions=instructions
            )
        else:
            modification = datapath.ofproto_parser.OFPFlowMod(
                datapath=datapath,
                priority=priority,
                match=match,
                instructions=instructions,
                buffer_id=buffer_id
            )
        datapath.send_msg(modification)
    
    def add_packet_in(self, datapath):
        self.logger.info("Packet In Message If no flows match!")
        match = datapath.ofproto_parser.OFPMatch()
        actions = [
            datapath.ofproto_parser.OFPActionOutput(
                datapath.ofproto.OFPP_CONTROLLER,
                datapath.ofproto.OFPCML_NO_BUFFER,
            ),
        ]
        self.add_flow(datapath, self.LOW, match, actions)

    def delete_all_flows(self, datapath):
        # Remove All flows in all tables
        match = datapath.ofproto_parser.OFPMatch()
        instructions = []
        flow_mod = datapath.ofproto_parser.OFPFlowMod(
            datapath=datapath,
            command=datapath.ofproto.OFPFC_DELETE,
            out_port=datapath.ofproto.OFPP_ANY,
            out_group=datapath.ofproto.OFPG_ANY,
            match=match,
            instructions=instructions
        )
        datapath.send_msg(flow_mod)
    
    def flood_all_arp(self, datapath):
        self.logger.info("Allowing all ARP traffic")
        match = datapath.ofproto_parser.OFPMatch(
            eth_type=ether.ETH_TYPE_ARP
        )
        actions = [
            datapath.ofproto_parser.OFPActionOutput(
                datapath.ofproto.OFPP_FLOOD,
                datapath.ofproto.OFPCML_NO_BUFFER,
            )
        ]
        self.add_flow(datapath, self.MEDIUM, match, actions)
    
    def send_shortest_paths(self):
        for _, datapath in self.network.datapath_map.items():
            self.delete_all_flows(datapath)
            self.flood_all_arp(datapath)
            self.add_packet_in(datapath)
        
        for host in self.network.shortest_paths:
            for switch, out_swicth in self.network.shortest_paths[host].items():
                datapath = self.network.datapath_map[switch]
                parser = datapath.ofproto_parser
                match = datapath.ofproto_parser.OFPMatch(eth_dst=host)
                out_port = self.network.get_next_port(switch, out_swicth, host)
                actions = [parser.OFPActionOutput(out_port)]
                self.add_flow(datapath, self.ULTRA, match, actions)

    @set_ev_cls(EventHostAdd, MAIN_DISPATCHER)
    def handle_host_add(self, ev):
        host = ev.host
        self.network.add_host(host.mac, host.port.dpid, host.port.port_no)
        self.logger.info("Host %s connected to switch %s at port %s",
                        host.mac, host.port.dpid, host.port.port_no)
        self.network.compute_shortest_paths()
        self.send_shortest_paths()
        self.network.print_graph()

    @set_ev_cls(EventHostDelete, MAIN_DISPATCHER)
    def handle_host_delete(self, ev):
        host = ev.host
        self.network.remove_host(host.mac)
        self.logger.info("Host %s disconnected from switch %s at port %s",
                        host.mac, host.port.dpid, host.port.port_no)
        self.network.compute_shortest_paths()
        self.send_shortest_paths()
        self.network.print_graph()
    
    @set_ev_cls(EventLinkAdd, MAIN_DISPATCHER)
    def link_added_handler(self, ev):
        link = ev.link
        self.network.add_link(link)
        self.logger.info("Link Added: %s", link)
        self.network.compute_shortest_paths()
        self.send_shortest_paths()
        self.network.print_graph()

    @set_ev_cls(EventLinkDelete, MAIN_DISPATCHER)
    def link_deleted_handler(self, ev):
        link = ev.link
        self.network.remove_link(link)
        self.logger.info("Link Deleted: %s", link)
        self.network.compute_shortest_paths()
        self.send_shortest_paths()
        self.network.print_graph()

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def handle_udp_packet(self, event):
        msg = event.msg
        datapath = event.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        pkt = packet.Packet(event.msg.data)
        eth = pkt.get_protocol(ethernet.ethernet)
        in_port = msg.match['in_port']

        # Extract the Destination Mac Address and Switch ID
        destination_mac = eth.dst
        dpid = datapath.id
        
        # The Fact that the controller did not find a flow for the packet
        # having the above destination MAC means the following cases has occured:
        
        # -----------------------------------------------------------------
        # Case 1: The shortest path exists but the flow is not installed
        # Solution: Install the flow for out_port on the switch due to delays
        next_switch = self.network.get_next_hop(destination_mac, dpid)
        out_port = None
        if next_switch:
            out_port = self.network.get_next_port(dpid, next_switch, destination_mac)
        # -----------------------------------------------------------------
        
        # -----------------------------------------------------------------
        # Case 2: The shortest Path has not been computed for the destination MAC
        #          This can happen if the destination MAC is not in the network
        #           Or is Currently inactive in the network
        # Solution: Flood the packet to all the switches in the network
        else:
            out_port = ofproto.OFPP_FLOOD
        # -----------------------------------------------------------------
        
        actions = [parser.OFPActionOutput(out_port)]
        # install a flow to avoid packet_in next time
        if out_port != ofproto.OFPP_FLOOD:
            match = datapath.ofproto_parser.OFPMatch(
                eth_dst=destination_mac
            )
            # verify if we have a valid buffer_id, if yes avoid to send both
            # flow_mod & packet_out
            if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                self.add_flow(datapath, self.ULTRA, match, actions, msg.buffer_id)
                return
            else:
                self.add_flow(datapath, self.ULTRA, match, actions)
        data = None
        if msg.buffer_id == ofproto.OFP_NO_BUFFER:
            data = msg.data
        out = parser.OFPPacketOut(datapath=datapath, buffer_id=msg.buffer_id,
                                  in_port=in_port, actions=actions, data=data)
        datapath.send_msg(out)
        
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def initial_switch_setup(self, event):
        datapath = event.msg.datapath
        self.logger.info("Switch %s connected to controller", datapath.id)
        self.delete_all_flows(datapath)
        self.logger.info("Deleted all flows from Switch: %s", datapath.id)
        self.add_packet_in(datapath)
        self.logger.info("Added Default Packet In Swicth: %s", datapath.id)

        self.network.add_node(datapath.id)
        self.network.add_datapath(datapath.id, datapath)

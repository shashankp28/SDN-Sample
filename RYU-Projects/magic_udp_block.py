"""
Host A to Host B communication only possible if
Host A sends a UDP packet with the string 'xxyyzz' in it.
Then the way is open
"""

from ryu.base import app_manager
from ryu.ofproto import ofproto_v1_4, ether, inet
from ryu.controller.handler import set_ev_cls, CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller import ofp_event
from ryu.lib.packet import packet, ethernet


class MagicControl(app_manager.RyuApp):

    OFP_VERSIONS = [ofproto_v1_4.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(MagicControl, self).__init__(*args, **kwargs)

    def add_flow(self, datapath, priority, match, actions):
        instructions = [
            datapath.ofproto_parser.OFPInstructionActions(
                datapath.ofproto.OFPIT_APPLY_ACTIONS,
                actions,
            )
        ]
        modification = datapath.ofproto_parser.OFPFlowMod(
            datapath=datapath,
            priority=priority,
            match=match,
            instructions=instructions
        )
        datapath.send_msg(modification)

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

    def block_all_traffic_h1(self, datapath):
        self.logger.info('Blocking traffic from h1 port')
        match_1 = datapath.ofproto_parser.OFPMatch(
            in_port=1
        )
        self.add_flow(datapath, 10, match_1, [])

        self.logger.info('Flood traffic from h2 port')
        match_2 = datapath.ofproto_parser.OFPMatch(
            in_port=2
        )
        actions = [
            datapath.ofproto_parser.OFPActionOutput(
                datapath.ofproto.OFPP_FLOOD,
                datapath.ofproto.OFPCML_NO_BUFFER,
            )
        ]
        self.add_flow(datapath, 10, match_2, actions)

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
        self.add_flow(datapath, 20, match, actions)

    def add_notify_on_magic_udp(self, datapath):
        self.logger.info("Add notification on UDP message")
        match = datapath.ofproto_parser.OFPMatch(
            in_port=1,
            eth_type=ether.ETH_TYPE_IP,
            ip_proto=inet.IPPROTO_UDP
        )
        actions = [
            datapath.ofproto_parser.OFPActionOutput(
                datapath.ofproto.OFPP_CONTROLLER,
                datapath.ofproto.OFPCML_NO_BUFFER,
            ),
        ]
        self.add_flow(datapath, 20, match, actions)

    def allow_from_host_1(self, datapath, src):
        self.logger.info("Allowing Traffic from host 1: %s", src)
        match = datapath.ofproto_parser.OFPMatch(
            eth_src=src,
        )
        actions = [
            datapath.ofproto_parser.OFPActionOutput(
                datapath.ofproto.OFPP_FLOOD,
                datapath.ofproto.OFPCML_NO_BUFFER,
            ),
        ]
        self.add_flow(datapath, 30, match, actions)

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def handle_udp_packet(self, event):
        datapath = event.msg.datapath
        pkt = packet.Packet(event.msg.data)
        eth = pkt.get_protocol(ethernet.ethernet)

        self.logger.info("Recieved UDP Packet from %s", eth.src)
        if event.msg.data.find(b'xxyyzz') >= 0:
            self.logger.info("Recieved Magic UDP Packet from %s", eth.src)
            self.allow_from_host_1(datapath, eth.src)

    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def initial_switch_setup(self, event):
        datapath = event.msg.datapath
        self.logger.info("Switch %s connected to controller", datapath.id)
        self.delete_all_flows(datapath)
        self.logger.info("Deleted all flows from switch %s", datapath.id)
        self.block_all_traffic_h1(datapath)
        self.logger.info("Blocked all traffic from h1 (LOW)")
        self.flood_all_arp(datapath)
        self.logger.info("Allowed all ARP traffic (MED)")
        self.add_notify_on_magic_udp(datapath)

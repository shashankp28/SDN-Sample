from mininet.topo import Topo
from mininet.net import Mininet
from mininet.cli import CLI
from mininet.node import RemoteController, OVSSwitch

class MyTopology(Topo):
    """
    Class to implement a 5-switch complete graph topology with one host per switch
    """
    def __init__(self, vertices):
        Topo.__init__(self)

        self.vertices = vertices

        # Create self.vertices switches
        switches = []
        for i in range(self.vertices):
            switch = self.addSwitch(f's{i}', dpid=format(i+1, '016X'), listen=6633)
            switches.append(switch)

        # Create self.vertices hosts and connect each host to a switch
        for i in range(self.vertices):
            host = self.addHost(f'h{i}', ip=f"10.1.1.{i+1}/24")
            self.addLink(host, switches[i])

        # Create links between switches to form a complete graph
        for i in range(self.vertices):
            for j in range(i+1, self.vertices):
                self.addLink(switches[i], switches[j])

topo = MyTopology(6)
net = Mininet(
    topo=topo,
    controller=lambda name: RemoteController(name, ip='172.17.0.2', port=6633),
    switch=OVSSwitch,
    autoSetMacs=True
)
net.start()
CLI(net)
net.stop()

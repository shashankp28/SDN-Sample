"""
Ring topology
"""
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.cli import CLI
from mininet.node import RemoteController, OVSSwitch


class MyTopology(Topo):

    """
    Class to implement Ring Topology
    """

    def __init__(self, N):
        Topo.__init__(self)
        self.vertices = N
        for i in range(self.vertices):
            host = self.addHost(f'h{i}', ip=f"10.1.1.{i+1}/24")
            dpid = format(i+1, '016X')
            switch = self.addSwitch(f's{i}', dpid=dpid, listen=6633)
            self.addLink(host, switch)

        for i in range(self.vertices):
            self.addLink(f's{i}', f's{(i+1)%self.vertices}')


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

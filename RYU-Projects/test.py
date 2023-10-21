from ryu.controller import ofp_event
from ryu.controller.handler import set_ev_cls, MAIN_DISPATCHER
from ryu.topology import event, switches
from ryu.base import app_manager

class YourTopologyApp(app_manager.RyuApp):

    def __init__(self, *args, **kwargs):
        super(YourTopologyApp, self).__init__(*args, **kwargs)

    @set_ev_cls(event.EventSwitchEnter)
    def switch_enter_handler(self, ev):
        # Handle the event when a new switch enters the network
        switch = ev.switch
        self.logger.info(f"New switch detected: DPID {switch.dp.id}")

    @set_ev_cls(event.EventSwitchLeave)
    def switch_leave_handler(self, ev):
        # Handle the event when a switch leaves the network
        switch = ev.switch
        self.logger.info(f"Switch disconnected: DPID {switch.dp.id}")

    @set_ev_cls(event.EventLinkAdd)
    def link_add_handler(self, ev):
        # Handle the event when a new link is added to the network
        link = ev.link
        self.logger.info(f"New link detected: {link.src.dpid} -> {link.dst.dpid}")

    @set_ev_cls(event.EventLinkDelete)
    def link_delete_handler(self, ev):
        # Handle the event when a link is deleted from the network
        link = ev.link
        self.logger.info(f"Link disconnected: {link.src.dpid} -> {link.dst.dpid}")

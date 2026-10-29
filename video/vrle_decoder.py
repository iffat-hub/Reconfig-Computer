import cocotb
from coccotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.clock import Clock
from cocotbext.axi import AxiStreamBus, AxiStreamSource, AxiStreamSink, AxiStreamMonitor

@cocotb.test()
async def test(dut):
    cocotb.fork(Clock(dut.clk, 10, units="ns").start())
    axis_source = AxiStreamSource(AxiStreamBus.from_prefix(dut, "s_axis"), dut.clk, dut.rst)
    axis_sink = AxiStreamSink(AxiStreamBus.from_prefix(dut, "m_axis"), dut.clk, dut.rst)
    axis_mon= AxiStreamMonitor(AxiStreamBus.from_prefix(dut.inst, "int_axis"), dut.clk, dut.rst)

    await axis_source.send([0x10,0x39,0x49,0x34])


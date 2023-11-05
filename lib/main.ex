defmodule Demo.Main do
  def start() do
    {:ok, lsa_topic} = Demo.Pubsub.start_link()
    {:ok, mpu_topic} = Demo.Pubsub.start_link()
    {:ok, output_topic} = Demo.Pubsub.start_link()
    {:ok,_mcu} = Demo.Mcu.start_link(lsa_topic, mpu_topic, output_topic)
    {:ok,_motors} = Demo.Motors.start_link(output_topic)
    {:ok, _lsa} = Demo.Lsa.start_link(lsa_topic)
    {:ok, _mpu} = Demo.Mpu.start_link(mpu_topic)
    Demo.Lsa.lsa_loop(lsa_topic)
    Demo.Mpu.mpu_loop(mpu_topic)
  end
end
# Demo.Main.start

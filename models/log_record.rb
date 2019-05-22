class LogRecord
  def initialize(address, client_ip)
    self.address = address
    self.client_ip = client_ip
  end

  attr_reader :address, :client_ip

  private

  attr_writer :address, :client_ip
end

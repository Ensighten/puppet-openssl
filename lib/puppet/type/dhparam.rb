require 'pathname'
Puppet::Type.newtype(:dhparam) do
  desc 'A Diffie Helman parameter file'

  ensurable

  newparam(:path, :namevar => true) do
    validate do |value|
      path = Pathname.new(value)
      unless path.absolute?
        raise ArgumentError, "Path must be absolute: #{path}"
      end
    end
  end

  newparam(:size) do
    desc 'The key size'
    newvalues /\d+/
    defaultto 512
    validate do |value|
      size = value
      if size <= 0 || size != size.to_i
        raise ArgumentError, "Size must be a positive integer: #{size.inspect}"
      end
    end
  end
end

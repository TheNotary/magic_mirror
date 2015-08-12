require 'spec_helper'

describe MagicMirror do
  it 'has a version number' do
    expect(MagicMirror::VERSION).not_to be nil
  end

  it 'exposes a binding' do
    m = MagicMirror.new
    m.init_servers
    binding.pry
  end
end

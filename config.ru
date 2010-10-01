Object.send(:remove_const, :Rack)
$:.reject! {|x| x =~ /rack-[\d\.]+\/lib/}
$".reject {|x| x =~ /^rack\/.*\.rb$/}
$".delete('rack.rb')
Gem.loaded_specs.delete("rack")

require 'bundler/setup'
Bundler.require
require 'pp'

run lambda {
  env = ENV.to_hash.to_a.sort_by {|(k,v)| k}
  body = <<-EOT
Gems:
#{Gem.source_index.gems.keys.sort.pretty_inspect}
Gem path:
#{Gem.path.sort.pretty_inspect}
ENV:
#{env.pretty_inspect}
  EOT
  Rack::Response.new(body, 200, {"Content-Type" => "text/plain"}).finish
}

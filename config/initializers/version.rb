module Lilion

  File.open(Rails.root.join("VERSION"), "rb") do |f|
    @@version = f.read.strip
  end

  mattr_reader :version

end


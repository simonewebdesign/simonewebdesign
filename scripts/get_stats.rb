#!/usr/bin/env ruby
require 'net/http'

initial_stats = {
  count_200: 0,
  count_404: 0,
  total: 0,
  hit: 0,
  miss: 0
}

res = Dir["source/_posts/*"]                        # get all posts
  .map do |pathname|                                # for each post
    File.open(pathname) do |file|                   # open file
      contents = file.read                          # read it
      matches = contents.match /^permalink: (.*)$/  # get permalink
      path = matches[1] if matches != nil
      if path == nil                                # if no permalink
        basename = File.basename(file, ".*")        # get basename
        matches = basename.match /^\d{4}-?\d{2}?-?\d{2}?-?(.*)$/
        path = matches[1]
        path = "/#{path}/"
      end
      path
    end
  end
  .map do |path|                                    # for each post
    uri = URI("https://simonewebdesign.it#{path}")  # HTTP GET it
    res = Net::HTTP.get_response(uri)
    cache_status = res.each_header.to_h['cf-cache-status']

    puts "#{res.code} #{uri} (#{cache_status})"

    [res.code, cache_status]
  end
  .inject(initial_stats) do |acc, el|               # gather stats
    success = el[0] == '200'
    failure = el[0] == '404'
    hit = el[1] == 'HIT'
    miss = el[1] == 'MISS'

    {
      count_200: success ? acc[:count_200] + 1 : acc[:count_200],
      count_404: failure ? acc[:count_404] + 1 : acc[:count_404],
      total: acc[:total] + 1,
      hit: hit ? acc[:hit] + 1 : acc[:hit],
      miss: miss ? acc[:miss] + 1 : acc[:miss]
    }
  end

success_percent = res[:count_200].to_f / res[:total] * 100
failure_percent = res[:count_404].to_f / res[:total] * 100
hit_percent = res[:hit].to_f / res[:total] * 100
miss_percent = res[:miss].to_f / res[:total] * 100

puts "
# Statistics

200: #{res[:count_200]} (#{success_percent.round(1)}%)
404: #{res[:count_404]} (#{failure_percent.round(1)}%)

Cache Hits:   #{res[:hit]} (#{hit_percent.round(1)}%)
Cache Misses: #{res[:miss]} (#{miss_percent.round(1)}%)

Total Requests: #{res[:total]}
"

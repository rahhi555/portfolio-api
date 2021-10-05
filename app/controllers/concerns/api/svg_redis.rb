# # frozen_string_literal: true
#
# module Api::SvgRedis
#   @redis ||= Redis.new(host: 'redis', db: 1)
#   @next_id ||= @redis.get('next:id').to_i
#
#   class << self
#     def update_all(map_id, svgs)
#       attrs = svgs.flat_map { |svg| [svg['id'], Oj.generate(svg)] }
#
#       @redis.hmset("map:#{map_id}", *attrs)
#     end
#
#     def create(map_id, svg)
#       incr_next_id if @next_id.nil?
#       done_retry = false
#       begin
#         result = false
#         @redis.multi do
#           result = @redis.hsetnx("map:#{map_id}", @next_id, Oj.dump(svg))
#           incr_next_id
#         end
#
#         raise ArgumentError unless result
#       rescue ArgumentError
#         if done_retry
#           logger.error 'svg_hsetメソッドが失敗しました'
#         else
#           done_retry = true
#           @next_id = @redis.get('next:id')
#           retry
#         end
#       end
#     end
#
#     def index(map_ids)
#       svgs = @redis.pipelined do
#         map_ids.each do |map_id|
#           @redis.hgetall("map:#{map_id}")
#         end
#       end
#       svgs[0].map { |svg_id, json| Oj.load(json).merge('id' => svg_id.to_i) }
#     end
#
#     def delete(map_id, svg_id)
#       @redis.hdel("map:#{map_id}", svg_id)
#     end
#
#     private
#
#     def incr_next_id
#       @redis.incr('next:id')
#       if @next_id.nil?
#         @next_id = 1
#       else
#         @next_id += 1
#       end
#     end
#   end
# end

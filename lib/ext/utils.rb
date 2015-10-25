module Snapstats
  def self.status
    
    '
    "snaps:1445731200:cpm"
    "snaps:1445731200:uniq"
    "snaps:1445731200:activity"
    "snaps:1445731200:browsers"
    "snaps:1445731200:performance:controllers"
    "snaps:1445731200:platforms"
    '

    {
      keys: @@redis.keys("snaps:*")
    }
  end

  def self.clear_all
    redis.keys("snaps*").each{ |key| redis.del(key) }
  end
end

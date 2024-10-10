class HashMap
  attr_accessor (:buckets)
  def initialize()
    @keys_count = 0
    @size = 16
    @buckets = Array.new(@size) {[]}
    @load_factor = 0.75
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord * prime_number }
    hash_code %= @size
    hash_code
  end

  def set(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket_slot = @buckets[index]
    if self.has?(key)
      # loop thru bucket and find
      @buckets[index] = bucket_slot.map do |k,v|
        k == key ? [key, value] : [k, v]
      end
      return
    end

    # not exist, append to end of array
    bucket_slot.push([key, value])
    @keys_count += 1

    # check capacity overload or not
    capacity = @keys_count.to_f / @size
    self.expand() if capacity >= @load_factor

    # p @buckets
    
  end

  def expand
    original_pairs = self.entries()
    @size *= 2
    @buckets  = @buckets = Array.new(@size) {[]}
    original_pairs.each do |k,v|
      self.set(k, v)
    end
  end

  def get(key)
    return nil if !has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket_slot = @buckets[index]
    bucket_slot.each { |k, v| return v if k == key}
  end

  def has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket_slot = @buckets[index]

    return false if bucket_slot.empty?

    bucket_slot.each {|k, v| return true if k == key}
    return false
  end

  def remove(key)
    return nil if !has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket_slot = @buckets[index] 
    @buckets[index] = bucket_slot.filter do |k, v|
      k != key
    end

    @keys_count -= 1
  end

  def length
    return @keys_count
  end

  def clear
    @keys_count = 0
    @size = 16
    @buckets = Array.new(@size) {[]}
  end

  def keys
    all_keys = []
    @buckets.each do |slot|
      slot.each do |k, _|
        all_keys.push(k)
      end
    end
    all_keys
  end

  def values
    all_values = []
    @buckets.each do |slot|
      slot.each do |_, v|
        all_values.push(v)
      end
    end
    all_values
  end

  def entries
    pairs = []
    @buckets.each do |slot|
      slot.each do |k, v|
        pairs.push([k, v])
      end
    end
    pairs
  end

end
class SeparateChainingHash < BaseHash
  def _initialize_store
    @store = []
  end

  def _put(int_key, key, value)
    @store[int_key] ||= []
    @store[int_key] << [ key, value ]
    return value
  end

  def _find(int_key, key)
    return nil if @store[int_key].nil?

    @store[int_key].each do |record|
      found_key = record[0]
      value = record[1]
      if found_key == key
        return int_key, value
      end
    end

    return nil
  end

  def _get(int_key, key)
    index, value = _find(int_key, key)

    if index.nil?
      return nil
    else
      return value
    end
  end

  def _del(int_key, key)
    index, value = _find(int_key, key)

    if index.nil?
      return nil
    else
      @store[index].delete([key, value])
      return value
    end
  end
end

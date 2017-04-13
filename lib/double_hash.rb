class DoubleHash < BaseHash
  def _initialize_store
    @store = []
  end

  def _hash2(index)
    return (5 - (index % 5))
  end

  def _put(int_key, key, value)
    step = _hash2(int_key)
    while ! @store[int_key].nil? && @store[int_key][0] != key
      int_key += step
    end

    @store[int_key] = [ key, value ]
    return value
  end

  def _find(int_key, key)
    value = @store[int_key]
    step = _hash2(int_key)
    while ! value.nil? && value[0] != key
      int_key += step
      value = @store[int_key]
    end

    if value.nil?
      return nil
    else
      return int_key, value
    end
  end

  def _get(int_key, key)
    index, value = _find(int_key, key)

    if index.nil?
      return nil
    else
      return value[1]
    end
  end

  def _del(int_key, key)
    index, value = _find(int_key, key)

    if index.nil?
      return nil
    else
      @store[index] = nil
      return value[1]
    end
  end
end

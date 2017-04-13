class BaseHash

  # Public: sub-classes should initialize their storage here.
  #
  # init_hash - initialize this hash with array data
  #
  # Returns new hash instance
  def initialize(init_hash = [])
    @keys = []
    _initialize_store

    i = 0
    while i < init_hash.size
      key = init_hash[i]
      val = init_hash[i + 1]
      put(key, val)
      i += 2
    end
  end

  def _initialize_store
    # Abstract base class does nothing.
  end

  # Public: puts a value in this hash by key.
  #
  # key - hash key
  # value - hash value
  #
  # Returns value
  def put(key, value)
    @keys << key

    case key.class.to_s
    when 'String'; put_string_key(key, value)
    when 'Fixnum'; put_integer_key(key, value)
    else; put_object_key(key, value)
    end

    return value
  end

  # Public: gets a value from this hash by key.
  #
  # key - hash key
  #
  # Returns value
  def get(key)
    return case key.class.to_s
           when 'String'; get_string_key(key)
           when 'Fixnum'; get_integer_key(key)
           else; get_object_key(key)
           end
  end

  # Public: removes a value from this hash by key.
  #
  # key - hash key
  #
  # Returns deleted value
  def del(key)
    @keys.delete(key)
    return case key.class.to_s
           when 'String'; del_string_key(key)
           when 'Fixnum'; del_integer_key(key)
           else; del_object_key(key)
           end
  end


  # Public: Returns a list of keys from this hash.
  #
  # Returns array of keys.
  def keys
    return @keys
  end

  # Private: Converts a string to a hashed int, for keying.
  #
  # string - input string
  #
  # Returns hashed int.
  def string2int(string)
    current_sum = 0
    strlen = string.length - 1
    (0..strlen).each do |i|
      j = strlen - i
      char = string[j]

      current_sum += (char.ord * (96 ** i))
    end

    return current_sum % 100000
  end

  def put_string_key(key, value)
    int_key = string2int(key)

    return _put(int_key, key, value)
  end

  def put_object_key(key, value)
    int_key = key.object_id % 1000000
    return _put(int_key, key, value)
  end

  def put_integer_key(key, value)
    return _put(key, key, value)
  end

  def _put(int_key, key, value)
    raise NotImplementedError, "subclass does not implement #_put"
  end

  def get_string_key(key)
    int_key = string2int(key)
    return _get(int_key, key)
  end

  def get_object_key(key)
    int_key = key.object_id
    return _get(int_key, key)
  end

  def get_integer_key(key)
    return _get(key, key)
  end

  def _get(int_key, key)
    raise NotImplementedError, "subclass does not implement #_get"
  end

  def del_string_key(key)
    int_key = string2int(key)
    return _del(int_key, key)
  end

  def del_object_key(key)
    int_key = key.object_id
    return _del(int_key, key)
  end

  def del_integer_key(key)
    return _del(key, key)
  end

  def _del(int_key, key)
    raise NotImplementedError, "subclass does not implement #_del"
  end

end

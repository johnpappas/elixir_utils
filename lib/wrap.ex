defmodule RedixWrapper do

  # Adds key=value mapping
  # Returns {:ok, "OK"} tuple if successful
  def rset(conn, key, val) do
    args = List.foldr(["SET", key, val], [], fn(x, acc) -> [x | acc] end)
    {:ok, _} =Redix.command(conn, args)
  end

  # Returns value mapped to key
  # (no tuple, just value returned due to ! (i.e., BANG notation in function))
  def rget(conn, key) do
    args = List.foldr(["GET", key], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # Sets a key's time to live in seconds
  # Returns # of seconds set
  def rexpire(conn, key, secs) do
    args = List.foldr(["EXPIRE", key, secs], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # TTL command
  # Returns #seconds left until key expires
  #         0 if key doesn't exist
  #         a negative integer (usually -1) if key has expired
  def r_ttl(conn, key, secs) do
    args = List.foldr(["EXPIRE", key, secs], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # SADD command
  # adds value to setname,
  # Returns 1 if new
  #         0 if duplicate
  def r_add_to_set(conn, setname, val) do
    args = List.foldr(["SADD", setname, val], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # SISMEMBER command
  # Returns 1 if member of set
  #         0 if not member
  def r_is_set_memeber(conn, setname, val) do
    args = List.foldr(["SISMEMBER", setname, val], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # SCARD command
  # Returns # of set members
  def r_get_number_of_set_members(conn, setname) do
    args = List.foldr(["SCARD", setname], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # HSET command
  # Add key=val to hash
  # Returns 1 if key is new in hash and val is set
  #         0 if key exists and val updated
  def r_set_hash_key_val(conn, hashname, key, val) do
    args = List.foldr(["HSET", hashname, key, val], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # HGET command
  # Gets val mapped to key from hash
  # Returns val mapped to key if it exists
  #         nil otherwise
  def r_get_hash_key_val(conn, hashname, key) do
    args = List.foldr(["HGET", hashname, key], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # HINCRBY command
  # Increments counter stored in hash by increment specified
  # Returns counter value AFTER increment
  def r_increment_hash_counter(conn, hashc, counter, incr_val) do
    args = List.foldr(["HINCRBY", hash, counter, incr_val], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # RPUSH command
  # Sets value to head of list
  # Returns len of list after push operation
  def r_set_to_list_tail(conn, listname, value) do
    args = List.foldr(["RPUSH", listname, value], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # LPOP command
  # Returns item at head of list
  #         nil if list is empty
  def r_get_from_list_head(conn, listname) do
    args = List.foldr(["LPOP", listname], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end

  # LLEN command
  # Returns length of list
  #         nil if not a list
  def r_get_list_length(conn, listname) do
    args = List.foldr(["LLEN", listname], [], fn(x, acc) -> [x | acc] end)
    Redix.command!(conn, args)
  end



end

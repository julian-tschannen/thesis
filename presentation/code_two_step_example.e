class PLAYER
feature
  pos: INTEGER

  play (d1, d2: DIE)
    do
      d1.r.forth
      d1.val := d1.r.in (1, 6)
      d2.r.forth
      d2.val := d1.r.in (1, 6)
      pos := pos + d1.val + d2.val
    ensure
      pos + 2 <= pos and pos <= pos + 12
    end
end

class DIE
feature

  val: INTEGER

  r: V_RANDOM

  roll
    do
      r.forth
      val := r.in (1, 6)
    end
end

class V_RANDOM
  in (min, max: INTEGER): INTEGER
    ensure
      min <= Result <= max
end


module Plasma
  include Treetop::Runtime

  def root
    @root || :plasma
  end

  def _nt_plasma
    start_index = index
    if node_cache[:plasma].has_key?(index)
      cached = node_cache[:plasma][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_decl
    if r1
      r0 = r1
    else
      r2 = _nt_seq
      if r2
        r0 = r2
      else
        r3 = _nt_quote
        if r3
          r0 = r3
        else
          r4 = _nt_defun
          if r4
            r0 = r4
          else
            r5 = _nt_def
            if r5
              r0 = r5
            else
              r6 = _nt_apply
              if r6
                r0 = r6
              else
                r7 = _nt_fun
                if r7
                  r0 = r7
                else
                  r8 = _nt_sym
                  if r8
                    r0 = r8
                  else
                    r9 = _nt_hash
                    if r9
                      r0 = r9
                    else
                      r10 = _nt_list
                      if r10
                        r0 = r10
                      else
                        r11 = _nt_date
                        if r11
                          r0 = r11
                        else
                          r12 = _nt_time
                          if r12
                            r0 = r12
                          else
                            r13 = _nt_str
                            if r13
                              r0 = r13
                            else
                              r14 = _nt_num
                              if r14
                                r0 = r14
                              else
                                self.index = i0
                                r0 = nil
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    node_cache[:plasma][start_index] = r0

    return r0
  end

  module Decl0
    def s
      elements[0]
    end

    def s
      elements[2]
    end

    def plasma
      elements[3]
    end
  end

  module Decl1
    def x
      elements[1]
    end

    def first
      elements[2]
    end

    def rest
      elements[3]
    end

    def x
      elements[4]
    end

  end

  def _nt_decl
    start_index = index
    if node_cache[:decl].has_key?(index)
      cached = node_cache[:decl][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('|', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('|')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        r4 = _nt_plasma
        if r4
          r3 = r4
        else
          r3 = SyntaxNode.new(input, index...index)
        end
        s0 << r3
        if r3
          s5, i5 = [], index
          loop do
            i6, s6 = index, []
            r7 = _nt_s
            s6 << r7
            if r7
              if input.index('|', index) == index
                r8 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('|')
                r8 = nil
              end
              s6 << r8
              if r8
                r9 = _nt_s
                s6 << r9
                if r9
                  r10 = _nt_plasma
                  s6 << r10
                end
              end
            end
            if s6.last
              r6 = (SyntaxNode).new(input, i6...index, s6)
              r6.extend(Decl0)
            else
              self.index = i6
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = SyntaxNode.new(input, i5...index, s5)
          s0 << r5
          if r5
            r11 = _nt_x
            s0 << r11
            if r11
              if input.index('|', index) == index
                r12 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('|')
                r12 = nil
              end
              s0 << r12
            end
          end
        end
      end
    end
    if s0.last
      r0 = (DeclNode).new(input, i0...index, s0)
      r0.extend(Decl1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:decl][start_index] = r0

    return r0
  end

  module Seq0
    def s
      elements[0]
    end

    def s
      elements[2]
    end

    def plasma
      elements[3]
    end
  end

  module Seq1
    def x
      elements[1]
    end

    def first
      elements[2]
    end

    def rest
      elements[3]
    end

    def x
      elements[4]
    end

  end

  def _nt_seq
    start_index = index
    if node_cache[:seq].has_key?(index)
      cached = node_cache[:seq][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('(', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        r4 = _nt_plasma
        if r4
          r3 = r4
        else
          r3 = SyntaxNode.new(input, index...index)
        end
        s0 << r3
        if r3
          s5, i5 = [], index
          loop do
            i6, s6 = index, []
            r7 = _nt_s
            s6 << r7
            if r7
              if input.index('|', index) == index
                r8 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('|')
                r8 = nil
              end
              s6 << r8
              if r8
                r9 = _nt_s
                s6 << r9
                if r9
                  r10 = _nt_plasma
                  s6 << r10
                end
              end
            end
            if s6.last
              r6 = (SyntaxNode).new(input, i6...index, s6)
              r6.extend(Seq0)
            else
              self.index = i6
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = SyntaxNode.new(input, i5...index, s5)
          s0 << r5
          if r5
            r11 = _nt_x
            s0 << r11
            if r11
              if input.index(')', index) == index
                r12 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(')')
                r12 = nil
              end
              s0 << r12
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SeqNode).new(input, i0...index, s0)
      r0.extend(Seq1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:seq][start_index] = r0

    return r0
  end

  module Quote0
    def plasma
      elements[1]
    end
  end

  def _nt_quote
    start_index = index
    if node_cache[:quote].has_key?(index)
      cached = node_cache[:quote][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("'", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("'")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_plasma
      s0 << r2
    end
    if s0.last
      r0 = (QuoteNode).new(input, i0...index, s0)
      r0.extend(Quote0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:quote][start_index] = r0

    return r0
  end

  module Defun0
    def s
      elements[1]
    end

    def params
      elements[2]
    end

    def s
      elements[3]
    end

    def plasma
      elements[4]
    end
  end

  def _nt_defun
    start_index = index
    if node_cache[:defun].has_key?(index)
      cached = node_cache[:defun][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('defun', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure('defun')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_s
      s0 << r2
      if r2
        r3 = _nt_params
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            r5 = _nt_plasma
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (DefunNode).new(input, i0...index, s0)
      r0.extend(Defun0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:defun][start_index] = r0

    return r0
  end

  module Def0
    def s
      elements[1]
    end

    def sym
      elements[2]
    end

    def s
      elements[3]
    end

    def plasma
      elements[4]
    end
  end

  def _nt_def
    start_index = index
    if node_cache[:def].has_key?(index)
      cached = node_cache[:def][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('def', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure('def')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_s
      s0 << r2
      if r2
        r3 = _nt_sym
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            r5 = _nt_plasma
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (DefNode).new(input, i0...index, s0)
      r0.extend(Def0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:def][start_index] = r0

    return r0
  end

  module Apply0
    def s
      elements[0]
    end

    def plasma
      elements[1]
    end
  end

  module Apply1
    def x
      elements[1]
    end

    def applied
      elements[2]
    end

    def s
      elements[3]
    end

    def first
      elements[4]
    end

    def rest
      elements[5]
    end

    def x
      elements[6]
    end

  end

  def _nt_apply
    start_index = index
    if node_cache[:apply].has_key?(index)
      cached = node_cache[:apply][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('(', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        i3 = index
        r4 = _nt_fun
        if r4
          r3 = r4
        else
          r5 = _nt_sym
          if r5
            r3 = r5
          else
            self.index = i3
            r3 = nil
          end
        end
        s0 << r3
        if r3
          r6 = _nt_s
          s0 << r6
          if r6
            r7 = _nt_plasma
            s0 << r7
            if r7
              s8, i8 = [], index
              loop do
                i9, s9 = index, []
                r10 = _nt_s
                s9 << r10
                if r10
                  r11 = _nt_plasma
                  s9 << r11
                end
                if s9.last
                  r9 = (SyntaxNode).new(input, i9...index, s9)
                  r9.extend(Apply0)
                else
                  self.index = i9
                  r9 = nil
                end
                if r9
                  s8 << r9
                else
                  break
                end
              end
              r8 = SyntaxNode.new(input, i8...index, s8)
              s0 << r8
              if r8
                r12 = _nt_x
                s0 << r12
                if r12
                  if input.index(')', index) == index
                    r13 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure(')')
                    r13 = nil
                  end
                  s0 << r13
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (ApplyNode).new(input, i0...index, s0)
      r0.extend(Apply1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:apply][start_index] = r0

    return r0
  end

  module Fun0
    def s
      elements[1]
    end

    def params
      elements[2]
    end

    def s
      elements[3]
    end

    def plasma
      elements[4]
    end
  end

  def _nt_fun
    start_index = index
    if node_cache[:fun].has_key?(index)
      cached = node_cache[:fun][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('fun', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure('fun')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_s
      s0 << r2
      if r2
        r3 = _nt_params
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            r5 = _nt_plasma
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (FunNode).new(input, i0...index, s0)
      r0.extend(Fun0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:fun][start_index] = r0

    return r0
  end

  module Params0
    def s
      elements[0]
    end

    def sym
      elements[1]
    end
  end

  module Params1
    def x
      elements[1]
    end

    def first
      elements[2]
    end

    def rest
      elements[3]
    end

    def x
      elements[4]
    end

  end

  def _nt_params
    start_index = index
    if node_cache[:params].has_key?(index)
      cached = node_cache[:params][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('(', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        r3 = _nt_sym
        s0 << r3
        if r3
          s4, i4 = [], index
          loop do
            i5, s5 = index, []
            r6 = _nt_s
            s5 << r6
            if r6
              r7 = _nt_sym
              s5 << r7
            end
            if s5.last
              r5 = (SyntaxNode).new(input, i5...index, s5)
              r5.extend(Params0)
            else
              self.index = i5
              r5 = nil
            end
            if r5
              s4 << r5
            else
              break
            end
          end
          r4 = SyntaxNode.new(input, i4...index, s4)
          s0 << r4
          if r4
            r8 = _nt_x
            s0 << r8
            if r8
              if input.index(')', index) == index
                r9 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(')')
                r9 = nil
              end
              s0 << r9
            end
          end
        end
      end
    end
    if s0.last
      r0 = (ParamsNode).new(input, i0...index, s0)
      r0.extend(Params1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:params][start_index] = r0

    return r0
  end

  def _nt_sym
    start_index = index
    if node_cache[:sym].has_key?(index)
      cached = node_cache[:sym][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[a-z+!/\\^&@?*%<>=_-]'), index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = SymNode.new(input, i0...index, s0)
    end

    node_cache[:sym][start_index] = r0

    return r0
  end

  module Hash0
    def s
      elements[0]
    end

    def relation
      elements[1]
    end
  end

  module Hash1
    def x
      elements[1]
    end

    def first
      elements[2]
    end

    def rest
      elements[3]
    end

    def x
      elements[4]
    end

  end

  def _nt_hash
    start_index = index
    if node_cache[:hash].has_key?(index)
      cached = node_cache[:hash][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('{', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('{')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        r4 = _nt_relation
        if r4
          r3 = r4
        else
          r3 = SyntaxNode.new(input, index...index)
        end
        s0 << r3
        if r3
          s5, i5 = [], index
          loop do
            i6, s6 = index, []
            r7 = _nt_s
            s6 << r7
            if r7
              r8 = _nt_relation
              s6 << r8
            end
            if s6.last
              r6 = (SyntaxNode).new(input, i6...index, s6)
              r6.extend(Hash0)
            else
              self.index = i6
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = SyntaxNode.new(input, i5...index, s5)
          s0 << r5
          if r5
            r9 = _nt_x
            s0 << r9
            if r9
              if input.index('}', index) == index
                r10 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('}')
                r10 = nil
              end
              s0 << r10
            end
          end
        end
      end
    end
    if s0.last
      r0 = (HashNode).new(input, i0...index, s0)
      r0.extend(Hash1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:hash][start_index] = r0

    return r0
  end

  module Relation0
    def sym
      elements[0]
    end

    def x
      elements[1]
    end

    def x
      elements[3]
    end

    def plasma
      elements[4]
    end
  end

  def _nt_relation
    start_index = index
    if node_cache[:relation].has_key?(index)
      cached = node_cache[:relation][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_sym
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        if input.index(':', index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(':')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_x
          s0 << r4
          if r4
            r5 = _nt_plasma
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (RelationNode).new(input, i0...index, s0)
      r0.extend(Relation0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:relation][start_index] = r0

    return r0
  end

  module List0
    def s
      elements[0]
    end

    def plasma
      elements[1]
    end
  end

  module List1
    def x
      elements[1]
    end

    def first
      elements[2]
    end

    def rest
      elements[3]
    end

    def x
      elements[4]
    end

  end

  def _nt_list
    start_index = index
    if node_cache[:list].has_key?(index)
      cached = node_cache[:list][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('[', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('[')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_x
      s0 << r2
      if r2
        r4 = _nt_plasma
        if r4
          r3 = r4
        else
          r3 = SyntaxNode.new(input, index...index)
        end
        s0 << r3
        if r3
          s5, i5 = [], index
          loop do
            i6, s6 = index, []
            r7 = _nt_s
            s6 << r7
            if r7
              r8 = _nt_plasma
              s6 << r8
            end
            if s6.last
              r6 = (SyntaxNode).new(input, i6...index, s6)
              r6.extend(List0)
            else
              self.index = i6
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = SyntaxNode.new(input, i5...index, s5)
          s0 << r5
          if r5
            r9 = _nt_x
            s0 << r9
            if r9
              if input.index(']', index) == index
                r10 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(']')
                r10 = nil
              end
              s0 << r10
            end
          end
        end
      end
    end
    if s0.last
      r0 = (ListNode).new(input, i0...index, s0)
      r0.extend(List1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:list][start_index] = r0

    return r0
  end

  module Date0
    def s
      elements[0]
    end

    def time
      elements[1]
    end
  end

  module Date1
    def year
      elements[0]
    end

    def month
      elements[2]
    end

    def day
      elements[4]
    end

  end

  def _nt_date
    start_index = index
    if node_cache[:date].has_key?(index)
      cached = node_cache[:date][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year
    s0 << r1
    if r1
      if input.index(Regexp.new('[-]'), index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_dual
        s0 << r3
        if r3
          if input.index(Regexp.new('[-]'), index) == index
            r4 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r4 = nil
          end
          s0 << r4
          if r4
            r5 = _nt_dual
            s0 << r5
            if r5
              i7, s7 = index, []
              r8 = _nt_s
              s7 << r8
              if r8
                r9 = _nt_time
                s7 << r9
              end
              if s7.last
                r7 = (SyntaxNode).new(input, i7...index, s7)
                r7.extend(Date0)
              else
                self.index = i7
                r7 = nil
              end
              if r7
                r6 = r7
              else
                r6 = SyntaxNode.new(input, index...index)
              end
              s0 << r6
            end
          end
        end
      end
    end
    if s0.last
      r0 = (DateNode).new(input, i0...index, s0)
      r0.extend(Date1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:date][start_index] = r0

    return r0
  end

  module Year0
  end

  def _nt_year
    start_index = index
    if node_cache[:year].has_key?(index)
      cached = node_cache[:year][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[0-9]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[0-9]'), index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        if input.index(Regexp.new('[0-9]'), index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        s0 << r3
        if r3
          if input.index(Regexp.new('[0-9]'), index) == index
            r4 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r4 = nil
          end
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Year0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:year][start_index] = r0

    return r0
  end

  module Dual0
  end

  def _nt_dual
    start_index = index
    if node_cache[:dual].has_key?(index)
      cached = node_cache[:dual][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[0-9]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[0-9]'), index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Dual0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:dual][start_index] = r0

    return r0
  end

  module Time0
    def hours
      elements[0]
    end

    def minutes
      elements[2]
    end

    def seconds
      elements[4]
    end
  end

  def _nt_time
    start_index = index
    if node_cache[:time].has_key?(index)
      cached = node_cache[:time][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_dual
    s0 << r1
    if r1
      if input.index(':', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(':')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_dual
        s0 << r3
        if r3
          if input.index(':', index) == index
            r4 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(':')
            r4 = nil
          end
          s0 << r4
          if r4
            r5 = _nt_dual
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (TimeNode).new(input, i0...index, s0)
      r0.extend(Time0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:time][start_index] = r0

    return r0
  end

  module Str0
    def first
      elements[1]
    end

    def rest
      elements[2]
    end

  end

  def _nt_str
    start_index = index
    if node_cache[:str].has_key?(index)
      cached = node_cache[:str][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('"', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[^"]'), index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = SyntaxNode.new(input, index...index)
      end
      s0 << r2
      if r2
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[^"]'), index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        r4 = SyntaxNode.new(input, i4...index, s4)
        s0 << r4
        if r4
          if input.index('"', index) == index
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('"')
            r6 = nil
          end
          s0 << r6
        end
      end
    end
    if s0.last
      r0 = (StrNode).new(input, i0...index, s0)
      r0.extend(Str0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:str][start_index] = r0

    return r0
  end

  module Num0
  end

  module Num1
    def whole
      elements[0]
    end

    def expansion
      elements[1]
    end
  end

  def _nt_num
    start_index = index
    if node_cache[:num].has_key?(index)
      cached = node_cache[:num][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    s1, i1 = [], index
    loop do
      if input.index(Regexp.new('[0-9]'), index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      if r2
        s1 << r2
      else
        break
      end
    end
    if s1.empty?
      self.index = i1
      r1 = nil
    else
      r1 = SyntaxNode.new(input, i1...index, s1)
    end
    s0 << r1
    if r1
      i4, s4 = index, []
      if input.index('.', index) == index
        r5 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('.')
        r5 = nil
      end
      s4 << r5
      if r5
        s6, i6 = [], index
        loop do
          if input.index(Regexp.new('[0-9]'), index) == index
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r7 = nil
          end
          if r7
            s6 << r7
          else
            break
          end
        end
        if s6.empty?
          self.index = i6
          r6 = nil
        else
          r6 = SyntaxNode.new(input, i6...index, s6)
        end
        s4 << r6
      end
      if s4.last
        r4 = (SyntaxNode).new(input, i4...index, s4)
        r4.extend(Num0)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r3 = r4
      else
        r3 = SyntaxNode.new(input, index...index)
      end
      s0 << r3
    end
    if s0.last
      r0 = (NumNode).new(input, i0...index, s0)
      r0.extend(Num1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:num][start_index] = r0

    return r0
  end

  def _nt_x
    start_index = index
    if node_cache[:x].has_key?(index)
      cached = node_cache[:x][index]
      @index = cached.interval.end if cached
      return cached
    end

    r1 = _nt_s
    if r1
      r0 = r1
    else
      r0 = SyntaxNode.new(input, index...index)
    end

    node_cache[:x][start_index] = r0

    return r0
  end

  def _nt_s
    start_index = index
    if node_cache[:s].has_key?(index)
      cached = node_cache[:s][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[ \\n]'), index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = SyntaxNode.new(input, i0...index, s0)
    end

    node_cache[:s][start_index] = r0

    return r0
  end

end

class PlasmaParser < Treetop::Runtime::CompiledParser
  include Plasma
end




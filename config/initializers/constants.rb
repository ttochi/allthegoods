# -*- encoding : utf-8 -*-
module Convertible
    def to_s(v)
        self::STR[v] unless v.nil?
    end

    def to_s2(v1, v2)
        self::STR2[v1][v2] unless v1.nil? || v2.nil?
    end

    def to_v(s)
        self::STR.index(s) unless s.nil?
    end

    def size
        self::STR.size
    end
end

module Constants
    module SaleState
        extend Convertible
        STR = %w[수량조사 선입금 일반입금 판매완료]
    end
end

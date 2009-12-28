class FacebookSignature
  class << self
    def calculate(secret, params)
      raise ArgumentError.new('The Facebook secret key is required to verify the signature.') if secret.blank?

      combined = params.inject([]) do |result, entry|
        key = entry[0]
        value = entry[1]
        result << "#{key[7..-1]}=#{value}" if key =~ /fb_sig_/
        result
      end

      combined.sort!
      combined << secret

      joined = combined.join('')
      signature = Digest::MD5.hexdigest(joined)
      signature
    end

    def valid?(secret, params)
      expected_digest = params['fb_sig']

      raise ArgumentError.new('The fb_sig param is required to verify the signature.') if expected_digest.blank?

      actual_digest = FacebookSignature.calculate(secret, params)
      expected_digest == actual_digest
    end
  end
end

module TonClient

  class Utils
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfConvertAddress
    # address: String -     # Account address in any TON format.
    # output_format: TSDKAddressStringFormat -     # Specify the format to convert to.
    # RESPONSE: TSDKResultOfConvertAddress
    # address: String -     # Address in the specified format
    def convert_address(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfCalcStorageFee
    # account: String - 
    # period: Number - 
    # RESPONSE: TSDKResultOfCalcStorageFee
    # fee: String - 
    def calc_storage_fee(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfCompressZstd
    # uncompressed: String -     # Uncompressed data.    # Must be encoded as base64.
    # level: Number -     # Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).
    # RESPONSE: TSDKResultOfCompressZstd
    # compressed: String -     # Compressed data.    # Must be encoded as base64.
    def compress_zstd(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfDecompressZstd
    # compressed: String -     # Compressed data.    # Must be encoded as base64.
    # RESPONSE: TSDKResultOfDecompressZstd
    # decompressed: String -     # Decompressed data.    # Must be encoded as base64.
    def decompress_zstd(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end


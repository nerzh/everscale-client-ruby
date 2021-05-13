module TonClient

  class Utils
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: ParamsOfConvertAddress
    # address: String -     # Account address in any TON format.
    # output_format: AddressStringFormat -     # Specify the format to convert to.
    # RESPONSE: ResultOfConvertAddress
    # address: String -     # Address in the specified format
    def convert_address(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfCalcStorageFee
    # account: String - 
    # period: Number - 
    # RESPONSE: ResultOfCalcStorageFee
    # fee: String - 
    def calc_storage_fee(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfCompressZstd
    # uncompressed: String -     # Uncompressed data.    # Must be encoded as base64.
    # level: Number<Optional> -     # Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).
    # RESPONSE: ResultOfCompressZstd
    # compressed: String -     # Compressed data.    # Must be encoded as base64.
    def compress_zstd(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfDecompressZstd
    # compressed: String -     # Compressed data.    # Must be encoded as base64.
    # RESPONSE: ResultOfDecompressZstd
    # decompressed: String -     # Decompressed data.    # Must be encoded as base64.
    def decompress_zstd(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end


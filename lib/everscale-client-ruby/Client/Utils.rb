module TonClient

  class Utils
    include CommonInstanceHelpers

    attr_reader :context, :request_id, :requests, :monitor
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: nil, request_id: nil, requests: nil, monitor: nil)
      @context = context
      @request_id = request_id
      @requests = requests
      @monitor = monitor
    end

    # INPUT: ParamsOfConvertAddress
    # address: String -     #     # Account address in any TON format.
    # output_format: AddressStringFormat -     #     # Specify the format to convert to.
    # RESPONSE: ResultOfConvertAddress
    # address: String -     #     # Address in the specified format
    def convert_address(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfGetAddressType
    # address: String -     #     # Account address in any TON format.
    # RESPONSE: ResultOfGetAddressType
    # address_type: AccountAddressType -     #     # Account address type.
    def get_address_type(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfCalcStorageFee
    # account: String - 
    # period: Number - 
    # RESPONSE: ResultOfCalcStorageFee
    # fee: String - 
    def calc_storage_fee(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfCompressZstd
    # uncompressed: String -     #     # Uncompressed data.    #     # Must be encoded as base64.
    # level: Number<Optional> -     #     # Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).
    # RESPONSE: ResultOfCompressZstd
    # compressed: String -     #     # Compressed data.    #     # Must be encoded as base64.
    def compress_zstd(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: ParamsOfDecompressZstd
    # compressed: String -     #     # Compressed data.    #     # Must be encoded as base64.
    # RESPONSE: ResultOfDecompressZstd
    # decompressed: String -     #     # Decompressed data.    #     # Must be encoded as base64.
    def decompress_zstd(payload, &block)
      TonBinding.requestLibrary(context: context, request_id: request_id, requests: requests, monitor: monitor, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end


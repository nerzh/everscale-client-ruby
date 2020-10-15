module TonClient
  
  class Contract

    TONAddressStringVariant = {
      AccountId: 'AccountId',
      Hex: 'Hex',
      Base64: 'Base64',
    }

    TONClientTransactionPhase = {
      storage: 'storage',
      computeSkipped: 'computeSkipped',
      computeVm: 'computeVm',
      action: 'action',
      unknown: 'unknown',
    }

    TONClientComputeSkippedStatus = {
      noState: 0,
      badState: 1,
      noGas: 2,
    }

    TONClientStorageStatus = {
      unchanged: 0,
      frozen: 1,
      deleted: 2,
    }

    QInMsgType = {
      external: 0,
      ihr: 1,
      immediately: 2,
      final: 3,
      transit: 4,
      discardedFinal: 5,
      discardedTransit: 6,
    }

    QOutMsgType = {
      external: 0,
      immediately: 1,
      outMsgNew: 2,
      transit: 3,
      dequeueImmediately: 4,
      dequeue: 5,
      transitRequired: 6,
      none: -1,
    }

    QMessageType = {
      internal: 0,
      extIn: 1,
      extOut: 2,
    }

    QMessageProcessingStatus = {
      unknown: 0,
      queued: 1,
      processing: 2,
      preliminary: 3,
      proposed: 4,
      finalized: 5,
      refused: 6,
      transiting: 7,
    }

    QBlockProcessingStatus = {
      unknown: 0,
      proposed: 1,
      finalized: 2,
      refused: 3,
    }

    QSplitType = {
      none: 0,
      split: 2,
      merge: 3,
    }

    QAccountType = {
      uninit: 0,
      active: 1,
      frozen: 2,
    }

    QTransactionType = {
      ordinary: 0,
      storage: 1,
      tick: 2,
      tock: 3,
      splitPrepare: 4,
      splitInstall: 5,
      mergePrepare: 6,
      mergeInstall: 7,
    }

    QTransactionProcessingStatus = {
      unknown: 0,
      preliminary: 1,
      proposed: 2,
      finalized: 3,
      refused: 4,
    }

    QAccountStatus = {
      uninit: 0,
      active: 1,
      frozen: 2,
      nonExist: 3,
    }

    QAccountStatusChange = {
      unchanged: 0,
      frozen: 1,
      deleted: 2,
    }

    QComputeType = {
      skipped: 0,
      vm: 1,
    }

    QSkipReason = {
      noState: 0,
      badState: 1,
      noGas: 2,
    }

    QBounceType = {
      negFunds: 0,
      noFunds: 1,
      ok: 2,
    }

    MASTERCHAIN_ID = -1
    EXTRA_TRANSACTION_WAITING_TIME = 10000
    BLOCK_TRANSACTION_WAITING_TIME = 5000

    attr_reader :context, :core

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context.id
      @core = core
    end

    
    # Facade functions

    # payload = {
    #     address: TONContractRunParams.address,
    #     abi: TONContractRunParams.abi,
    #     functionName: TONContractRunParams.functionName,
    #     header: TONContractRunParams.header,
    #     tryIndex: retryIndex,
    #     input: TONContractRunParams.input,
    #     keyPair: TONContractRunParams.keyPair,
    # }
    def run(payload)
      core.send_request(context: context, method_name: 'contracts.run', payload: payload)
    end

    # payload = {
    #     address,
    #     account,
    #     abi: TONContractRunMessageLocalParams.abi,
    #     functionName: TONContractRunMessageLocalParams.functionName,
    #     messageBase64: TONContractRunMessageLocalParams.messageBodyBase64,
    #     fullRun: TONContractRunMessageLocalParams.fullRun,
    # }
    def run_local_msg(payload)
      core.send_request(context: context, method_name: 'contracts.run.local.msg', payload: payload)
    end



    # payload = {
    #     address,
    #     account,
    #     abi: TONContractRunLocalParams.abi,
    #     functionName: TONContractRunLocalParams.functionName,
    #     input: TONContractRunLocalParams.input,
    #     keyPair: TONContractRunLocalParams.keyPair,
    #     fullRun: TONContractRunLocalParams.fullRun,
    # }
    def run_local(payload)
      core.send_request(context: context, method_name: 'contracts.run.local', payload: payload)
    end

    # payload = {
    #     address: TONContractCalcRunFeeParams.address,
    #     account,
    #     abi: TONContractCalcRunFeeParams.abi,
    #     functionName: TONContractCalcRunFeeParams.functionName,
    #     input: TONContractCalcRunFeeParams.input,
    #     keyPair: TONContractCalcRunFeeParams.keyPair,
    # }
    def run_fee(payload)
      core.send_request(context: context, method_name: 'contracts.run.fee', payload: payload)
    end

    # payload = {
    #     abi: TONContractABI,
    #     function: string,
    #     header?: any,
    #     params: any,
    #     internal?: boolean,
    #     keyPair?: TONKeyPairData,
    # }
    def run_body(payload)
      core.send_request(context: context, method_name: 'contracts.run.body', payload: payload)
    end

    # payload = {
    #     abi: TONContractABI,
    #     bodyBase64: string,
    #     internal?: boolean,
    # }
    def run_unknown_input(payload)
      core.send_request(context: context, method_name: 'contracts.run.unknown.input', payload: payload)
    end

    # payload = {
    #     abi: TONContractABI,
    #     bodyBase64: string,
    #     internal?: boolean,
    # }
    def run_unknown_output(payload)
      core.send_request(context: context, method_name: 'contracts.run.unknown.output', payload: payload)
    end

    # payload = {
    #     address: TONContractCalcMsgProcessingFeesParams.address,
    #     account,
    #     messageBase64: TONContractCalcMsgProcessingFeesParams.message.messageBodyBase64,
    # }
    def run_fee_msg(payload)
      core.send_request(context: context, method_name: 'contracts.run.fee.msg', payload: payload)
    end

    # payload = {
    #     address: TONContractRunParams.address,
    #     abi: TONContractRunParams.abi,
    #     functionName: TONContractRunParams.functionName,
    #     header: TONContractRunParams.header,
    #     tryIndex: retryIndex,
    #     input: TONContractRunParams.input,
    #     keyPair: TONContractRunParams.keyPair,
    # }
    def run_message(payload)
      core.send_request(context: context, method_name: 'contracts.run.message', payload: payload)
    end

    # payload = {
    #     abi: TONContractABI,
    #     functionName: string,
    #     bodyBase64: string,
    #     internal?: boolean,
    # }
    def run_output(payload)
      core.send_request(context: context, method_name: 'contracts.run.output', payload: payload)
    end

    # payload = {
    #     address: TONContractRunParams.address,
    #     abi: TONContractRunParams.abi,
    #     functionName: TONContractRunParams.functionName,
    #     header: TONContractRunParams.header,
    #     tryIndex: retryIndex,
    #     input: TONContractRunParams.input,
    # }
    def run_encode_unsigned_message(payload)
      core.send_request(context: context, method_name: 'contracts.run.encode_unsigned_message', payload: payload)
    end

    # payload = {
    #     abi: TONContractConvertAddressParams.package.abi,
    #     constructorHeader: TONContractConvertAddressParams.constructorHeader,
    #     constructorParams: TONContractConvertAddressParams.constructorParams,
    #     initParams: TONContractConvertAddressParams.initParams,
    #     imageBase64: TONContractConvertAddressParams.package.imageBase64,
    #     keyPair: TONContractConvertAddressParams.keyPair,
    # }
    def deploy(payload)
      core.send_request(context: context, method_name: 'contracts.deploy', payload: payload)
    end

    # payload = {
    #     abi: TONContractDeployParams.package.abi,
    #     constructorHeader: TONContractDeployParams.constructorHeader,
    #     tryIndex: retryIndex,
    #     constructorParams: TONContractDeployParams.constructorParams,
    #     initParams: TONContractDeployParams.initParams,
    #     imageBase64: TONContractDeployParams.package.imageBase64,
    #     publicKeyHex: TONContractDeployParams.keyPair.public,
    #     workchainId: TONContractDeployParams.workchainId,
    # }
    def deploy_encode_unsigned_message(payload)
      core.send_request(context: context, method_name: 'contracts.deploy.encode_unsigned_message', payload: payload)
    end

    # payload = {
    #     abi?: TONContractABI,
    #     initParams?: any,
    #     imageBase64?: string,
    #     publicKeyHex: string,
    #     workchainId?: number,
    # }
    def deploy_data(payload)
      core.send_request(context: context, method_name: 'contracts.deploy.data', payload: payload)
    end

    # payload = {
    #     abi: TONContractDeployParams.package.abi,
    #     constructorHeader: TONContractDeployParams.constructorHeader,
    #     constructorParams: TONContractDeployParams.constructorParams,
    #     initParams: TONContractDeployParams.initParams,
    #     imageBase64: TONContractDeployParams.package.imageBase64,
    #     keyPair: TONContractDeployParams.keyPair,
    #     workchainId: TONContractDeployParams.workchainId,
    # }
    def deploy_message(payload)
      core.send_request(context: context, method_name: 'contracts.deploy.message', payload: payload)
    end

    # payload = {
    #     transaction: string,
    #     abi: QTransaction,
    #     functionName: ?TONContractABI,
    #     address: ?string
    # }
    def process_transaction(payload)
      core.send_request(context: context, method_name: 'contracts.process.transaction', payload: payload)
    end

    # payload = {
    #     bocBase64?: string,
    #     codeBase64?: string, // Obsolete, use bocBase64
    #     dataBase64?: string, // Obsolete, use bocBase64
    #     functionName: string,
    #     input?: any,
    #     address?: string,
    #     balance?: string,
    #     acc_type?: number,
    #     id?: string,
    #     last_paid?: number,
    #     due_payment?: string,
    #     last_trans_lt?: string,
    #     balance?: string,
    #     split_depth?: number,
    #     tick?: boolean,
    #     tock?: boolean,
    #     code_hash?: string,
    #     data_hash?: string,
    #     library?: string,
    # }
    def tvm_get(payload)
      core.send_request(context: context, method_name: 'tvm.get', payload: payload)
    end

    # payload = {
    #     address,
    #     account,
    #     messageBase64: string,
    #     time: number,
    #     mainError: Error,
    # }
    def resolve_error(payload)
      core.send_request(context: context, method_name: 'contracts.resolve.error', payload: payload)
    end

    # payload ={
    #     bocBase64: string,
    # }
    def parse_message(payload)
      core.send_request(context: context, method_name: 'contracts.parse.message', payload: payload)
    end

    # payload = {
    #     abi: TONContractABI,
    #     unsignedBytesBase64: string,
    #     signBytesBase64: string,
    #     publicKeyHex?: string,
    # }
    def encode_message_with_sign(payload)
      core.send_request(context: context, method_name: 'contracts.encode_message_with_sign', payload: payload)
    end

    # payload = {
    #     abi: TONContractABI,
    #     function: string,
    #     input: boolean,
    # }
    def function_id(payload)
      core.send_request(context: context, method_name: 'contracts.function.id', payload: payload)
    end

    # payload = {
    #     address: string,
    #     convertTo: TONAddressStringVariantType,
    #     base64Params?: TONContractAddressBase64Params,
    # }
    def address_convert(payload)
      core.send_request(context: context, method_name: 'contracts.address.convert', payload: payload)
    end

    # payload = {
    #     shards: string,
    #     address: QShardHash[]
    # }
    def find_shard(payload)
      core.send_request(context: context, method_name: 'contracts.find.shard', payload: payload)
    end

    # payload = {
    #     params: TONContractMessage,
    #     parentSpan?: (Span | SpanContext),
    # }
    def send_message(payload)
      core.send_request(context: context, method_name: 'contracts.find.shard', payload: payload)
    end

    # payload = {
    #     message: TONContractMessage,
    #     resultFields: string,
    #     parentSpan?: (Span | SpanContext),
    #     retryIndex?: number,
    #     address?: string,
    #     abi?: TONContractABI,
    #     functionName?: string
    # }
    def process_message(payload)
      core.send_request(context: context, method_name: 'contracts.find.shard', payload: payload)
    end






















  end
end

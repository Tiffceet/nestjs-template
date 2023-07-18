import { Inject, Injectable } from "@nestjs/common";
import { PromotionService } from "../../promotion/promotion.service";
import { TransactionService } from "src/modules/transaction/transaction.service";

@Injectable()
export class PromotionTransactionAggregateService {
    @Inject(PromotionService)
    private readonly promotionService: PromotionService
    @Inject(TransactionService)
    private readonly transactionService: TransactionService

    createPromotionTransaction() {
        console.log("PromotionTransactionAggregateService.createPromotionTransaction")
    }
}
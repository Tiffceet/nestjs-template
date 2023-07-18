import { Injectable } from "@nestjs/common";

// TODO How to fix aggregates
// TODO How to fix direct prisma access
// TODO Where to put db implementations
// TODO Is it possible to split by business domain

/**
 * Establish:
 * - Service CANNOT have db access
 */

/**
 * Conclusion:
 * - NEED dto that fully represent db schema
 */
@Injectable()
export class PromotionService {
    
}
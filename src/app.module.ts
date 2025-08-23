import { Module } from '@nestjs/common';

import { BusinessModule } from './simulator/bussiness/business.module';
import { LearningModule } from './simulator/learning/learning.module';
import { SizeModule } from './simulator/size/size.module';
import { ModuleModule } from './simulator/module/module.module';
import { BusinessProgressStepModule } from './simulator/bussinessProgress/business-progress-step.module';
import { StatusModule } from './simulator/status/status.module';
import { FinancialRecordModule } from './simulator/financial-record/financial-record.module';

import { AnalisisIAModule } from './simulator/analysis_ai/analysis_ai.module';
import { AnalyzedCostResultModule } from './simulator/results_costs_analyzed/analyzed_cost_result.module';
import { OmittedCostResultModule } from './simulator/results_omitted_costs/omitted-cost-result.module';
import { DetectedRiskResultModule } from './simulator/results_risks_detected/detected-risk-result.module';
import { ActionPlanResultModule } from './simulator/results_action_plan/action-plan-result.module';
import { AiModule } from './simulator/ai/ai.module';




@Module({
  imports: [

   BusinessModule,
   LearningModule,
   SizeModule,
   ModuleModule,
   BusinessProgressStepModule,
   StatusModule,
   FinancialRecordModule,

   AnalisisIAModule,
   AnalyzedCostResultModule,
   OmittedCostResultModule,
   DetectedRiskResultModule,
   ActionPlanResultModule,
   AiModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}

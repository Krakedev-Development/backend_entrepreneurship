import { Module } from '@nestjs/common';

import { BusinessModule } from './simulator/bussiness/business.module';
import { LearningModule } from './simulator/learning/learning.module';
import { SizeModule } from './simulator/size/size.module';
import { ModuleModule } from './simulator/module/module.module';
import { BusinessProgressStepModule } from './simulator/bussinessProgress/business-progress-step.module';
import { StatusModule } from './simulator/status/status.module';
import { FinancialRecordModule } from './simulator/financial-record/financial-record.module';

@Module({
  imports: [

   BusinessModule,
   LearningModule,
   SizeModule,
   ModuleModule,
   BusinessProgressStepModule,
   StatusModule,
   FinancialRecordModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}

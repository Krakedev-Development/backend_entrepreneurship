import { Module } from '@nestjs/common';

import { BusinessModule } from './simulator/bussiness/business.module';

@Module({
  imports: [

   BusinessModule 
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}

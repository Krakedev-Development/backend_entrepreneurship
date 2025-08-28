import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../shared/database/prisma.service';
import { ValidationResultMapper } from '../models/mappers/validation-result.mapper';
import { ValidationResult } from '../models/entities/validation-result.entity';
import { SaveValidationResultDto } from '../models/dto/save-validation-result.dto';

@Injectable()
export class ValidationResultService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly mapper: ValidationResultMapper,
  ) {}

  async saveValidationResult(saveDto: SaveValidationResultDto): Promise<ValidationResult> {
    const validationResultPrisma = await this.prisma.resultados_Validacion_Costos.create({
      data: {
        negocio_id: saveDto.negocioId,
        modulo_id: saveDto.moduloId,
        costos_validados: saveDto.costosValidados,
        costos_faltantes: saveDto.costosFaltantes,
        resumen_validacion: saveDto.resumenValidacion,
        puntuacion_global: saveDto.puntuacionGlobal,
        puede_proseguir_analisis: saveDto.puedeProseguirAnalisis,
      },
    });

    return this.mapper.toDomain(validationResultPrisma);
  }

  async getValidationResultByBusinessAndModule(negocioId: number, moduloId: number): Promise<ValidationResult | null> {
    const validationResultPrisma = await this.prisma.resultados_Validacion_Costos.findFirst({
      where: {
        negocio_id: negocioId,
        modulo_id: moduloId,
      },
      orderBy: {
        fecha_validacion: 'desc',
      },
    });

    if (!validationResultPrisma) {
      return null;
    }

    return this.mapper.toDomain(validationResultPrisma);
  }

  async getValidationResultsByBusiness(negocioId: number): Promise<ValidationResult[]> {
    const validationResultsPrisma = await this.prisma.resultados_Validacion_Costos.findMany({
      where: {
        negocio_id: negocioId,
      },
      orderBy: {
        fecha_validacion: 'desc',
      },
    });

    return validationResultsPrisma.map(result => this.mapper.toDomain(result));
  }
}

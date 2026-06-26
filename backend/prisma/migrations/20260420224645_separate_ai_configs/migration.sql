-- AlterTable
ALTER TABLE "system_settings" ADD COLUMN     "memory_extraction_provider" VARCHAR(50) NOT NULL DEFAULT 'openai',
ADD COLUMN     "titling_llm_model" VARCHAR(100),
ADD COLUMN     "titling_llm_provider" VARCHAR(50) NOT NULL DEFAULT 'openai';

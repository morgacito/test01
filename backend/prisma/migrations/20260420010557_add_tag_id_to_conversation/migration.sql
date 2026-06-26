-- AlterTable
ALTER TABLE "conversations" ADD COLUMN     "tag_id" INTEGER;

-- AddForeignKey
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;

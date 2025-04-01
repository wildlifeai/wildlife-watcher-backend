import fs from 'fs';
import path from 'path';
import { BlobServiceClient } from '@azure/storage-blob';

/**
 * Uploads a file to Azure Blob Storage
 * @param filePath The full path to the file to upload
 * @returns Promise that resolves when upload is complete
 */
export const uploadToAzure = async (filePath: string): Promise<void> => {
  try {
    // Check if file exists
    if (!fs.existsSync(filePath)) {
      console.error(`File ${filePath} does not exist. Skipping upload.`);
      return;
    }

    // Get Azure Storage connection string from environment variable
    const connectionString = process.env.AZURE_STORAGE_CONNECTION_STRING;
    if (!connectionString) {
      throw new Error('Azure Storage connection string is not defined');
    }

    const containerName = process.env.AZURE_BACKUP_CONTAINER || 'backups';
    const blobName = path.basename(filePath);

    // Create the BlobServiceClient
    const blobServiceClient = BlobServiceClient.fromConnectionString(connectionString);
    const containerClient = blobServiceClient.getContainerClient(containerName);

    // Create container if it doesn't exist
    await containerClient.createIfNotExists();

    // Get a reference to a blob
    const blockBlobClient = containerClient.getBlockBlobClient(blobName);

    // Upload file
    console.log(`Uploading file to Azure Blob Storage: ${blobName}`);
    await blockBlobClient.uploadFile(filePath);
    console.log(`File successfully uploaded to Azure Blob Storage container '${containerName}'`);
  } catch (error) {
    console.error('Failed to upload file to Azure Blob Storage:', error);
    throw error;
  }
};

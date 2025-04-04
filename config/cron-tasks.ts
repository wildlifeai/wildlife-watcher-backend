import { uploadToAzure } from '../utils/azure-storage';

export default {
  backupDbJob: {
    task: ({ strapi }) => {
      const { execSync } = require('child_process');
      const fs = require('fs');
      const path = require('path');

      // Ensure backups directory exists
      const backupsDir = path.join(process.cwd(), process.env.BACKUP_DIR || 'backups');
      if (!fs.existsSync(backupsDir)) {
        fs.mkdirSync(backupsDir, { recursive: true });
      }

      // Create filename with timestamp
      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const appVersion = strapi.config.get('info.version', 'unknown');
      const backupFilename = path.join(backupsDir, `strapi-backup-${timestamp}-v${appVersion}`);

      // Execute backup command
      console.log(`Creating database backup at ${backupFilename}`);
      try {
        execSync(`npm run strapi export -- --no-encrypt --file "${backupFilename}"`);
        console.log('Database backup completed successfully');

        // Execute the upload with error handling
        const backupFile = `${backupFilename}.tar.gz`;
        uploadToAzure(backupFile)
          .then(() => {
            console.log('Backup file uploaded to Azure successfully');
          })
          .catch((error) => {
            console.error('Error during backup upload:', error);
          });
      } catch (error) {
        console.error('Database backup failed:', error);
      }
    },
    options: {
      // Schedule the task to run daily at 1 AM
      rule: "0 0 1 * * *",
    },
  },
};

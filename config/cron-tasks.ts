export default {
  backupDbJob: {
    task: ({ strapi }) => {
      const { execSync } = require('child_process');
      const fs = require('fs');
      const path = require('path');

      // Ensure backups directory exists
      const backupsDir = path.join(process.cwd(), 'backups');
      if (!fs.existsSync(backupsDir)) {
        fs.mkdirSync(backupsDir, { recursive: true });
      }

      // Create filename with timestamp
      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const backupFilename = path.join(backupsDir, `strapi-backup-${timestamp}.tar.gz`);

      // Execute backup command
      console.log(`Creating database backup at ${backupFilename}`);
      execSync(`npm run strapi export -- --no-encrypt --file "${backupFilename}"`);
      console.log('Database backup completed successfully');
    },
    options: {
      // Schedule the task to run daily at 1 AM
      rule: "0 0 1 * * *",
    },
  },
};

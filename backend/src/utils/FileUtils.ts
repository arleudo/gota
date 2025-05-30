import * as fs from "fs";
const UTF_8 = "utf-8";

export class FileUtils {
  public static loadFromFile<T>(filePath: string): T[] {
    try {
      const data = fs.readFileSync(filePath, UTF_8);
      return JSON.parse(data) as T[];
    } catch (error) {
      return [];
    }
  }

  public static saveToFile<T>(data: T[], filePath: string): void {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), UTF_8);
  }
}

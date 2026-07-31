import "dotenv/config";
import {drizzle} from "drizzle-orm/node-postgres";
import { usersTable } from "./db/schema";
import { eq } from "drizzle-orm"; 

const db = drizzle(process.env.DATABASE_URL!);

async function main() {
    const user: typeof usersTable.$inferInsert = {
        name: 'John',
        age: 30,
        email: 'john@example.com'
    };

    await db.insert(usersTable).values(user);
    console.log('User inserted successfully');

    const users = await db.select().from(usersTable);
    console.log('Users:', users);

    await db.update(usersTable).set({ age: 31 }).where(eq(usersTable.email, user.email));
    console.log('User updated successfully');

    await db.delete(usersTable).where(eq(usersTable.email, user.email));
    console.log('User deleted successfully');
}

main().catch(console.error);

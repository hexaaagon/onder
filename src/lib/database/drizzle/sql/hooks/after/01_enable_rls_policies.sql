-- Enable Row Level Security on user-related tables
-- This ensures that users can only access their own data

-- Enable RLS on user table (users can only see their own profile)
ALTER TABLE "user" ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own profile" ON "user";
CREATE POLICY "Users can view own profile"
ON "user"
FOR SELECT
USING (id = current_user_id());

DROP POLICY IF EXISTS "Users can update own profile" ON "user";
CREATE POLICY "Users can update own profile"
ON "user"
FOR UPDATE
USING (id = current_user_id());

-- Enable RLS on session table (users can only see their own sessions)
ALTER TABLE "session" ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can read/write their own sessions" ON "session";
CREATE POLICY "Users can read/write their own sessions"
ON "session"
FOR ALL
USING ("user_id" = current_user_id());

-- Enable RLS on account table (users can only see their own accounts)
ALTER TABLE "account" ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can read/write their own accounts" ON "account";
CREATE POLICY "Users can read/write their own accounts"
ON "account"
FOR ALL
USING ("user_id" = current_user_id());

-- Enable RLS on verification table (users can only see their own verifications)
ALTER TABLE "verification" ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can read/write their own verifications" ON "verification";
CREATE POLICY "Users can read/write their own verifications"
ON "verification"
FOR ALL
USING (identifier = (SELECT email FROM "user" WHERE id = current_user_id()));
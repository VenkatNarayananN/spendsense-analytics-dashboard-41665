-- 002_enable_rls_policies.sql
-- Enable RLS and define policies to restrict access to user-owned data.

-- PROFILES
alter table public.profiles enable row level security;

drop policy if exists "Profiles are viewable by owner" on public.profiles;
create policy "Profiles are viewable by owner"
on public.profiles for select
to authenticated
using (auth.uid() = id);

drop policy if exists "Profiles are insertable by owner" on public.profiles;
create policy "Profiles are insertable by owner"
on public.profiles for insert
to authenticated
with check (auth.uid() = id);

drop policy if exists "Profiles are updatable by owner" on public.profiles;
create policy "Profiles are updatable by owner"
on public.profiles for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

-- TRANSACTIONS
alter table public.transactions enable row level security;

drop policy if exists "Transactions are selectable by owner" on public.transactions;
create policy "Transactions are selectable by owner"
on public.transactions for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Transactions are insertable by owner" on public.transactions;
create policy "Transactions are insertable by owner"
on public.transactions for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Transactions are updatable by owner" on public.transactions;
create policy "Transactions are updatable by owner"
on public.transactions for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Transactions are deletable by owner" on public.transactions;
create policy "Transactions are deletable by owner"
on public.transactions for delete
to authenticated
using (auth.uid() = user_id);

-- ALERTS
alter table public.alerts enable row level security;

drop policy if exists "Alerts are selectable by owner" on public.alerts;
create policy "Alerts are selectable by owner"
on public.alerts for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Alerts are insertable by owner" on public.alerts;
create policy "Alerts are insertable by owner"
on public.alerts for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Alerts are updatable by owner" on public.alerts;
create policy "Alerts are updatable by owner"
on public.alerts for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Alerts are deletable by owner" on public.alerts;
create policy "Alerts are deletable by owner"
on public.alerts for delete
to authenticated
using (auth.uid() = user_id);

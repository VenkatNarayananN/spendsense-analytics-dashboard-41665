-- 001_create_profiles_transactions_alerts.sql
-- Core tables for SpendSense demo app.

create extension if not exists "uuid-ossp";

-- Profiles table: 1:1 with auth.users
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Transactions: spending records owned by a user
create table if not exists public.transactions (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  occurred_at timestamptz not null default now(),
  merchant text not null,
  category text not null,
  amount numeric(12,2) not null check (amount >= 0),
  currency text not null default 'USD',
  note text,
  created_at timestamptz not null default now()
);

create index if not exists transactions_user_id_idx on public.transactions(user_id);
create index if not exists transactions_occurred_at_idx on public.transactions(occurred_at);

-- Alerts: simple user-owned alerts (e.g., budget thresholds)
create table if not exists public.alerts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  type text not null,
  message text not null,
  severity text not null default 'info' check (severity in ('info','warning','critical')),
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create index if not exists alerts_user_id_idx on public.alerts(user_id);
create index if not exists alerts_is_read_idx on public.alerts(is_read);

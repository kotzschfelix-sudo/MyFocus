-- MyFocus: private focus-session history for each MyDigital account.
create table if not exists public.focus_sessions (
  id uuid primary key default gen_random_uuid(),
  owner uuid not null references auth.users(id) on delete cascade,
  session_type text not null default 'focus' check (session_type in ('focus','short_break','long_break')),
  planned_seconds integer not null check (planned_seconds between 60 and 86400),
  actual_seconds integer not null default 0 check (actual_seconds between 0 and 86400),
  completed boolean not null default false,
  started_at timestamptz not null default now(),
  ended_at timestamptz,
  created_at timestamptz not null default now()
);
alter table public.focus_sessions enable row level security;
drop policy if exists "Users can read own focus sessions" on public.focus_sessions;
create policy "Users can read own focus sessions" on public.focus_sessions for select to authenticated using ((select auth.uid()) = owner);
drop policy if exists "Users can insert own focus sessions" on public.focus_sessions;
create policy "Users can insert own focus sessions" on public.focus_sessions for insert to authenticated with check ((select auth.uid()) = owner);
drop policy if exists "Users can update own focus sessions" on public.focus_sessions;
create policy "Users can update own focus sessions" on public.focus_sessions for update to authenticated using ((select auth.uid()) = owner) with check ((select auth.uid()) = owner);
drop policy if exists "Users can delete own focus sessions" on public.focus_sessions;
create policy "Users can delete own focus sessions" on public.focus_sessions for delete to authenticated using ((select auth.uid()) = owner);
grant select, insert, update, delete on public.focus_sessions to authenticated;
create index if not exists focus_sessions_owner_started_idx on public.focus_sessions (owner, started_at desc);

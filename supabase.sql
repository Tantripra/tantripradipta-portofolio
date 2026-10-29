create table if not exists public.comments (
    id bigint generated always as identity primary key,
    name text not null check (char_length(btrim(name)) between 1 and 60),
    comment text not null check (char_length(btrim(comment)) between 1 and 1000),
    created_at timestamptz not null default now()
);

alter table public.comments enable row level security;

grant select on public.comments to anon;
grant insert (name, comment) on public.comments to anon;

drop policy if exists "Anyone can read comments" on public.comments;
create policy "Anyone can read comments"
    on public.comments
    for select
    to anon
    using (true);

drop policy if exists "Anyone can post comments" on public.comments;
create policy "Anyone can post comments"
    on public.comments
    for insert
    to anon
    with check (true);

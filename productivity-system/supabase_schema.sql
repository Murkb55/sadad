-- ══════════════════════════════════════════
-- نظام الإنجاز الذكي — Supabase Schema
-- نفّذ هذا في Supabase > SQL Editor
-- ══════════════════════════════════════════

-- جدول المهام
create table if not exists tasks (
  id          bigserial primary key,
  text        text not null,
  priority    text not null default 'med' check (priority in ('high','med','low')),
  category    text not null default 'other',
  done        boolean not null default false,
  date        text not null,
  ai_suggested boolean default false,
  subtasks    jsonb default '[]'::jsonb,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- جدول سجل الأيام (للـ streak)
create table if not exists day_history (
  id          bigserial primary key,
  day_key     text not null unique,
  done_count  int not null default 0,
  updated_at  timestamptz default now()
);

-- جدول الملاحظات
create table if not exists notes (
  id          bigserial primary key,
  content     text default '',
  updated_at  timestamptz default now()
);

-- إدراج سطر واحد للملاحظات
insert into notes (content) values ('') on conflict do nothing;

-- تفعيل Row Level Security (عام - بدون تسجيل دخول للاستخدام الشخصي)
alter table tasks enable row level security;
alter table day_history enable row level security;
alter table notes enable row level security;

-- سياسات الوصول المفتوح (للاستخدام الشخصي — يمكن تقييدها لاحقاً بـ Auth)
create policy "allow_all_tasks"       on tasks       for all using (true) with check (true);
create policy "allow_all_history"     on day_history for all using (true) with check (true);
create policy "allow_all_notes"       on notes       for all using (true) with check (true);

-- دالة تحديث updated_at تلقائياً
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger tasks_updated_at       before update on tasks       for each row execute function update_updated_at();
create trigger day_history_updated_at before update on day_history for each row execute function update_updated_at();
create trigger notes_updated_at       before update on notes       for each row execute function update_updated_at();

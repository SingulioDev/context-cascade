

---
name: react-specialist
version: 1.0.0
description: |
  Modern React development specialist for React 18+ with hooks, context, suspense, server components (Next.js 13+), state management (Redux/Zustand/Jotai), performance optimization (React.memo, useMemo,
category: Frontend Specialists
tags:
- general
author: system
---

# React Specialist

Expert React development for modern, performant, and maintainable frontend applications.

## Purpose

Provide comprehensive React expertise including React 18+ features (concurrent rendering, suspense, server components), performance optimization, state management patterns, and production-grade component architecture. Ensures React applications follow best practices and leverage the latest React capabilities.

## When to Use This Skill

- Building React applications with modern patterns
- Optimizing React performance (re-renders, bundle size, lazy loading)
- Implementing complex state management (global state, server state)
- Creating reusable component libraries with TypeScript
- Migrating to React 18+ or Next.js App Router
- Setting up React testing with React Testing Library and Jest
- Implementing accessibility (a11y) in React components

## Prerequisites

**Required**: JavaScript ES6+, TypeScript basics, HTML/CSS, npm/yarn/pnpm

**Agent Assignments**: `coder` (implementation), `tester` (React Testing Library), `mobile-dev` (React Native if needed)

## Core Workflows

### Workflow 1: Next.js 13+ App Router with Server Components

**Step 1: Initialize Next.js Project**

```bash
npx create-next-app@latest my-app --typescript --tailwind --app --no-src-dir
cd my-app
pnpm install
```

**Step 2: Create Server Component (RSC)**

```tsx
// app/users/page.tsx (Server Component by default)
import { Suspense } from 'react';
import { UserList } from './user-list';
import { UserSkeleton } from './user-skeleton';

async function getUsers() {
  const res = await fetch('https://api.example.com/users', {
    next: { revalidate: 60 } // ISR: revalidate every 60s
  });
  return res.json();
}

export default async function UsersPage() {
  const users = await getUsers();

  return (
    <main>
      <h1>Users</h1>
      <Suspense fallback={<UserSkeleton />}>
        <UserList users={users} />
      </Suspense>
    </main>
  );
}
```

**Step 3: Create Client Component with Interactivity**

```tsx
// app/users/user-list.tsx
'use client'; // Marks as Client Component

import { useState } from 'react';

interface User {
  id: number;
  name: string;
  email: string;
}

export function UserList({ users }: { users: User[] }) {
  const [filter, setFilter] = useState('');

  const filtered = users.filter(u =>
    u.name.toLowerCase().includes(filter.toLowerCase())
  );

  return (
    <div>
      <input
        type="text"
        placeholder="Filter users..."
        value={filter}
        onChange={(e) => setFilter(e.target.value)}
        className="border p-2 mb-4"
      />
      <ul>
        {filtered.map(user => (
          <li key={user.id}>{user.name} ({user.email})</li>
        ))}
      </ul>
    </div>
  );
}
```

**Step 4: Implement Server Actions**

```tsx
// app/actions.ts
'use server';

import { revalidatePath } from 'next/cache';

export async function createUser(formData: FormData) {
  const name = formData.get('name') as string;
  const email = formData.get('email') as string;

  await fetch('https://api.example.com/users', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ name, email }),
  });

  revalidatePath('/users'); // Revalidate users page
}
```

### Workflow 2: State Management with Zustand

**Step 1: Install Zustand**

```bash
pnpm add zustand
```

**Step 2: Create Type-Safe Store**

```tsx
// stores/user-store.ts
import { create } from 'zustand';
import { devtools, persist } from 'zustand/middleware';

interface User {
  id: number;
  name: string;
}

interface UserState {
  users: User[];
  addUser: (user: User) => void;
  removeUser: (id: number) => void;
  clearUsers: () => void;
}

export const useUserStore = create<UserState>()(
  devtools(
    persist(
      (set) => ({
        users: [],
        addUser: (user) => set((state) => ({
          users: [...state.users,


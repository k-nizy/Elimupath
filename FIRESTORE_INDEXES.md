# Firestore Composite Indexes

This document lists the composite indexes required for efficient Firestore queries in the ElimuPath application.

## Required Composite Indexes

### 1. Schools Collection - Filtered Search

**Collection:** `schools`

**Query:** Filter by combination (array-contains) AND admissionStatus AND feesPerTerm

**Index Fields:**
- `combinations` (array)
- `admissionStatus` (ascending)
- `feesPerTerm` (ascending)

**Purpose:** Enables efficient filtering of schools by subject combinations, admission status, and fee range simultaneously.

**Firestore Console Setup:**
1. Go to Firestore → Indexes
2. Click "Add Index"
3. Collection ID: `schools`
4. Fields:
   - `combinations` → Array
   - `admissionStatus` → Ascending
   - `feesPerTerm` → Ascending

### 2. Schools Collection - District + Admission Status

**Collection:** `schools`

**Query:** Filter by district AND admissionStatus

**Index Fields:**
- `district` (ascending)
- `admissionStatus` (ascending)

**Purpose:** Enables efficient filtering of schools by district and whether admissions are open.

**Firestore Console Setup:**
1. Go to Firestore → Indexes
2. Click "Add Index"
3. Collection ID: `schools`
4. Fields:
   - `district` → Ascending
   - `admissionStatus` → Ascending

### 3. Applications Collection - Student + Status

**Collection:** `applications`

**Query:** Get applications for a specific student with status filtering

**Index Fields:**
- `studentId` (ascending)
- `status` (ascending)

**Purpose:** Enables efficient retrieval of a student's applications filtered by status.

**Firestore Console Setup:**
1. Go to Firestore → Indexes
2. Click "Add Index"
3. Collection ID: `applications`
4. Fields:
   - `studentId` → Ascending
   - `status` → Ascending

### 4. Applications Collection - School + Status

**Collection:** `applications`

**Query:** Get applications for a specific school with status filtering

**Index Fields:**
- `schoolId` (ascending)
- `status` (ascending)

**Purpose:** Enables efficient retrieval of a school's applications filtered by status for admin review.

**Firestore Console Setup:**
1. Go to Firestore → Indexes
2. Click "Add Index"
3. Collection ID: `applications`
4. Fields:
   - `schoolId` → Ascending
   - `status` → Ascending

### 5. Favorites Collection - User + AddedAt

**Collection:** `favorites`

**Query:** Get user's favorites ordered by date added

**Index Fields:**
- `userId` (ascending)
- `addedAt` (descending)

**Purpose:** Enables efficient retrieval of a user's favorites sorted by most recently added.

**Firestore Console Setup:**
1. Go to Firestore → Indexes
2. Click "Add Index"
3. Collection ID: `favorites`
4. Fields:
   - `userId` → Ascending
   - `addedAt` → Descending

### 6. Announcements Collection - School + PostedAt

**Collection:** `announcements`

**Query:** Get school's announcements ordered by date posted

**Index Fields:**
- `schoolId` (ascending)
- `postedAt` (descending)

**Purpose:** Enables efficient retrieval of a school's announcements sorted by most recently posted.

**Firestore Console Setup:**
1. Go to Firestore → Indexes
2. Click "Add Index"
3. Collection ID: `announcements`
4. Fields:
   - `schoolId` → Ascending
   - `postedAt` → Descending

## Auto-Created Single Field Indexes

Firestore automatically creates single field indexes for all fields. The following are explicitly used:

- `users.id` (document ID)
- `schools.id` (document ID)
- `schools.adminId`
- `applications.id` (document ID)
- `favorites.id` (document ID)
- `announcements.id` (document ID)

## Index Creation Status

- [ ] Index 1: Schools combination + admissionStatus + feesPerTerm
- [ ] Index 2: Schools district + admissionStatus
- [ ] Index 3: Applications studentId + status
- [ ] Index 4: Applications schoolId + status
- [ ] Index 5: Favorites userId + addedAt
- [ ] Index 6: Announcements schoolId + postedAt

## Notes

- These indexes must be created in the Firebase Console before the app can perform the corresponding queries
- Without these indexes, queries will fail with "The query requires an index" error
- Index creation typically takes 1-2 minutes to complete
- Monitor index creation status in the Firebase Console under Firestore → Indexes

# CREATIVE BALLOON — Brand Website & Growth Platform

> **"A creative growth agency where strategy, digital marketing and cinematic production work together."**  
> *Sri Lanka & Worldwide • Ideas That Rise.*

---

## 1. Brand Concept & Positioning: "THE LIFT"
Creative Balloon is built at the intersection of conversion-focused digital marketing (inspired by high-performance growth architectures) and world-class visual production storytelling.

The balloon represents an idea rising through the value chain:
$$\text{IDEA} \longrightarrow \text{LIFT} \longrightarrow \text{ATTENTION} \longrightarrow \text{CONNECTION} \longrightarrow \text{GROWTH}$$

### Core Brand Dividers & Mantras
- *“Lift the idea.”*
- *“Lift the story.”*
- *“Lift the brand.”*
- *“Built to be seen.”*
- *“Where strategy meets story.”*
- *“Creative that moves brands forward.”*
- *“IDEAS THAT RISE.”*

---

## 2. Visual Design System

| Element | Specification | Hex / Font |
|---|---|---|
| **Background (Near Black)** | Deepest matte studio canvas | `#0A0A0C` |
| **Surface (Charcoal)** | Elevated panels & cards | `#131317` |
| **Elevated Surfaces** | Interactive hover cards & inputs | `#191920` / `#21212B` |
| **Typography (Warm White)** | High-contrast editorial headers | `#F5F2EB` |
| **Typography (Muted Text)** | Soft grey narrative body | `#9A9891` |
| **Accent Color ("Lift" Vermilion)** | Signal Vermilion / Lift Orange | `#FF4D2D` |
| **Display Headlines** | Bold Geometric Sans | `Syne` (800 / 700) |
| **Secondary Headings** | Clean Technical Grotesque | `Space Grotesk` (600 / 700) |
| **Body Typography** | International High-Legibility Sans | `Inter` (300 / 400 / 500) |
| **Micro Labels & Numbers** | Precision Monospace | `Space Mono` / `JetBrains Mono` |

---

## 3. Architecture & File Structure

```
creative-balloon/
├── index.html               # Main homepage featuring all 9 core agency sections
├── services.html            # Dedicated deep-dive into all 3 pillars and 19 services
├── case-study.html          # Standalone case study template view (?id=...)
├── css/
│   ├── main.css             # Design tokens, typography, glassmorphism, animations
│   └── responsive.css       # Mobile & tablet fluid viewport adaptations
├── js/
│   ├── logo-component.js    # Modular "B" monogram & logotype component
│   ├── case-studies-data.js # Rich portfolio dataset with editable metric placeholders
│   ├── services-data.js     # 3 Pillars with What It Is, Why It Matters, What We Deliver
│   ├── app.js               # Interaction engine (Showreel modal, Loop stepper, 9-field form)
│   └── services-page.js     # Dynamic renderer for the dedicated services page
├── server.rb                # Fast, zero-dependency Ruby WEBrick preview server
├── test_site.rb             # Automated test suite (61 verification checks)
└── README.md                # Documentation & client customization guide
```

---

## 4. How to Customize the Brand Mark (Logo)

The logo is encapsulated in **`js/logo-component.js`** so it can be updated in a single place across the entire website.

### Option A: Using Your Own PNG or SVG File
1. Place your logo file inside `assets/images/` (e.g., `assets/images/my-logo.svg` or `my-logo.png`).
2. Open `js/logo-component.js`.
3. Change:
   ```javascript
   USE_EXTERNAL_IMAGE: true,
   IMAGE_PATH: 'assets/images/my-logo.svg',
   ```
4. Refresh your browser. All logo instances in headers, footers, and overlays will update immediately.

### Option B: Modifying the Geometric Monogram SVG
Edit the inline SVG path inside `getLogoSVG()` in `js/logo-component.js`.

---

## 5. How to Update Case Studies & Images

Open **`js/case-studies-data.js`**:
Each project is structured with exact fields:
- `id`: Unique slug (e.g. `ceylon-artisan-roasters`)
- `title`: Hero campaign headline
- `client`: Client brand name
- `categories`: `["ALL", "CAMPAIGNS", "FILM", "SOCIAL", "PHOTOGRAPHY", "BRANDING", "DIGITAL"]`
- `heroImage`: URL or local relative path (`assets/images/...`)
- `challenge`, `idea`, `strategy`, `creative`, `production`, `digitalExecution`
- `impactMetric`: Prominent statistic (e.g., `+240% DTC SALES`)
- `impactDetails`: Array of 4 sub-metrics with notes
- `quote`: Client testimonial text, author, and title
- `gallery`: Array of behind-the-scenes photography stills

---

## 6. How to Update Services & Capabilities

Open **`js/services-data.js`**:
Services are organized under three pillars:
1. `digital-growth` (Social Media Strategy, Digital Advertising, Content Strategy, Performance Marketing, Lead Generation, Analytics & Optimisation)
2. `creative` (Campaign Concepts, Creative Direction, Brand Content, Social Creative, Copywriting, Art Direction)
3. `visual-production` (Commercial Films, Brand Films, Social Media Videos, Photography, Product Films, Event Production, Post Production)

Each individual service contains:
- `whatItIs`
- `whyItMatters`
- `whatWeDeliver` (Array of deliverables)

---

## 7. Conversational 9-Field Enquiry Form

The enquiry form on the homepage and footer triggers a smooth asynchronous submission flow and fires conversion data layer events (`window.dataLayer.push({ event: 'cb_enquiry_submitted', ... })`).

Fields include:
1. **Name**
2. **Company**
3. **Email**
4. **WhatsApp / Phone**
5. **Project Type** (Select dropdown)
6. **What do you need?** (Interactive multi-select pills)
7. **Estimated Timeline** (Immediate, 1-3 Months, 3-6 Months, Long-term Retainer)
8. **Budget Range** (Segmented tier pills with LKR & USD equivalents)
9. **Message** (Vision & objective textarea)

---

## 8. Running the Local Preview Server

To start the local server:
```bash
ruby server.rb
```
Then visit:
```
http://localhost:3000
```

To run the automated quality verification test suite:
```bash
ruby test_site.rb
```

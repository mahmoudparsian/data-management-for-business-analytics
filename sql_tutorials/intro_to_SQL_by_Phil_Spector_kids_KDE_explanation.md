# Kernel Density Estimation (KDE) — Clear Explanation (Markdown-Safe)

The previous version used LaTeX math, which some Markdown renderers do **not** support.  
This version uses **plain text and code blocks**, fully compatible with all Markdown viewers.

---

## ⭐ What is KDE?

**Kernel Density Estimation (KDE)** is a way to estimate the **shape of a distribution** using smooth curves instead of histogram bars.

KDE = **smooth histogram**.

---

## 🧠 Intuition

- Each data point is replaced with a small smooth bump (usually a bell curve).  
- Add all bumps together → you get a smooth distribution curve.  
- The result is a **continuous density estimate**.

---

## 🎨 Visual Intuition

Histogram:

```
|██      |
|██████  |
|██████████  |
```

KDE:

```
      /￣￣＼
   __/      ＼___
__/              ＼____
```

---

## 📘 Plain-Text Formula (Markdown Safe)

**KDE formula in words:**

```
Estimated density at x =
    (1 / (n * bandwidth)) *
    sum over all data points of:
        kernel( (x - xi) / bandwidth )
```

Where:

- **n** = number of data points  
- **xi** = each observed value  
- **kernel(...)** = usually a Gaussian bell curve  
- **bandwidth** = smoothness parameter  

---

## 🔑 Key Concepts

### ✔ Kernel
A smooth curve centered on each point (usually Gaussian).

### ✔ Bandwidth (h)
Controls smoothness:

```
Large bandwidth  → very smooth curve
Small bandwidth  → lots of detail (may be noisy)
```

### ✔ Result
A smooth estimate of the probability density.

---

## 💻 Python Example (uses gaussian_kde)

```python
from scipy.stats import gaussian_kde
import numpy as np
import matplotlib.pyplot as plt

data = df["height"].dropna().to_numpy()

kde = gaussian_kde(data)
xs = np.linspace(min(data), max(data), 200)

plt.plot(xs, kde(xs))
plt.xlabel("Height")
plt.ylabel("Density")
plt.title("KDE Density — Height")
plt.show()
```

---

## 🏁 When to Use KDE

- You want smooth visualization of distributions  
- You want to compare groups (race, gender, etc.)  
- You want to find peaks/trends in data  

---

## ❗ When NOT to Use KDE

- Very small sample sizes  
- Highly multimodal data  
- When exact frequencies are required  

---

End of file.

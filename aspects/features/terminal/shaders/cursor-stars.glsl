// Sparse off-white stars that fade in and out across the entire window.
float starHash(vec2 seed) {
    vec3 p = fract(vec3(seed.xyx) * 0.1031);
    p += dot(p, p.yzx + 33.33);
    return fract((p.x + p.y) * p.z);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord / iResolution.xy);

    const float spacing = 80.0;
    vec2 cell = floor(fragCoord / spacing);
    float seed = starHash(cell);
    if (seed < 0.4) {
        return;
    }

    // Each star has an independent 5–9 second cycle, including a dark pause.
    float age = iTime / mix(5.0, 9.0, starHash(cell + 7.3)) + starHash(cell + 19.7);
    float cycle = floor(age);
    float phase = fract(age);
    float fade = smoothstep(0.0, 0.3, phase)
        * (1.0 - smoothstep(0.4, 0.75, phase));

    // Change position only while invisible, leaving room around cell edges.
    vec2 position = vec2(
        starHash(cell + cycle * 13.7 + 3.1),
        starHash(cell + cycle * 23.9 + 8.4)
    );
    vec2 delta = fragCoord - (cell + 0.1 + position * 0.8) * spacing;
    if (max(abs(delta.x), abs(delta.y)) > 5.0) {
        return;
    }

    float radius = mix(0.65, 1.1, starHash(cell + 41.0));
    float core = exp(-dot(delta, delta) / (radius * radius));
    float rays = exp(-abs(delta.x) * 3.5 - abs(delta.y) * 0.9)
        + exp(-abs(delta.y) * 3.5 - abs(delta.x) * 0.9);

    // Suppress the effect over bright text and preserve window transparency.
    float luminance = dot(fragColor.rgb, vec3(0.2126, 0.7152, 0.0722));
    float background = 1.0 - smoothstep(0.06, 0.3, luminance);
    float opacity = 1.15 * fade * background * (0.32 * core + 0.045 * rays);
    vec3 offWhite = vec3(0.92, 0.91, 0.88);
    fragColor.rgb = mix(fragColor.rgb, offWhite * fragColor.a, opacity);
}

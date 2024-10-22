# image-enhancement-MFCB
Multilayer Fusion and Chunk-Based Transmittance Estimation for Natural Hazy Image Enhancement
https://ieeexplore.ieee.org/document/8812689

Aiming at the uneven distribution of haze concentration and color imbalance in haze weather images, a natural hazy image enhancement method which combines with multilayer fusion and chunk-based is proposed. Based on the atmospheric physical model, the detail and base layers of scene images can be extracted using multilayer decomposition and nonlinear mapping function. Iterative Box Filter can improve the accuracy of ambient light selection and avoid the imbalance of ambient light estimation. The image is segmented into blocks, and the block images are processed by the same operations which are multilayer decomposition and nonlinear mapping function to obtain the detail maps of block images. By splicing these detail maps into the whole detail maps and combining with the dark channel priori, a good transmittance estimation map can be obtained. Throughout the experiment, the guide image filter is utilized to preserve the edges of the image and color correction is added to the model. The experiment results demonstrate that our proposed method can outperform state-of-the-art methods in both qualitative and quantitative comparisons.

**It should be noted that the start of parallel pool in MATLAB takes some time

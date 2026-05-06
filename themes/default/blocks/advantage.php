<?php
/**
 * 首页区块：我们的优势
 */
$bg = getBlockBg($block ?? [], 'bg-dark text-white');
$advIcons = getAdvantageIcons();
$advDefaults = [
    ['icon' => 'check-circle', 'title' => '品質保証', 'desc' => '厳格な品質管理で、すべての製品が基準を満たすことを保証します'],
    ['icon' => 'academic-cap', 'title' => '技術力', 'desc' => '継続的な研究開発で、技術の優位性を維持します'],
    ['icon' => 'briefcase',    'title' => '専門サポート', 'desc' => '専門チームによる24時間365日テクニカルサポート'],
    ['icon' => 'users',        'title' => '共創共栄', 'desc' => 'お客様との長期的なパートナーシップで、互いの成長を実現します'],
];
?>
<section class="py-16 <?php echo $bg['class']; ?>" <?php echo $bg['style']; ?>>
    <?php echo $bg['overlay']; ?>
    <div class="<?php echo $bg['container']; ?> <?php echo $bg['content']; ?>">
        <div class="text-center mb-12" data-animate="fade-up">
            <h2 class="text-3xl font-bold mb-2"><?php echo __('home_our_advantage'); ?></h2>
            <span class="section-title-bar section-title-bar-light"></span>
            <p class="text-gray-400 mt-4"><?php echo e(config('home_advantage_desc', 'プロフェッショナルチームによる高品質サービス')); ?></p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8" data-stagger>
            <?php for ($i = 0; $i < 4; $i++):
                $n = $i + 1;
                $iconKey = config("home_adv_{$n}_icon", $advDefaults[$i]['icon']);
                $iconSvg = $advIcons[$iconKey]['svg'] ?? $advIcons['check-circle']['svg'];
            ?>
            <div class="text-center p-6">
                <div class="w-16 h-16 bg-primary rounded-full flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20"><?php echo $iconSvg; ?></svg>
                </div>
                <h3 class="text-xl font-bold mb-2"><?php echo e(config("home_adv_{$n}_title", $advDefaults[$i]['title'])); ?></h3>
                <p class="text-gray-400 text-sm"><?php echo e(config("home_adv_{$n}_desc", $advDefaults[$i]['desc'])); ?></p>
            </div>
            <?php endfor; ?>
        </div>
    </div>
</section>

# FintechKids — образовательное приложение по финансовой грамотности для детей

## 📱 Описание приложения

FintechKids — это интерактивное iOS-приложение, которое учит детей финансовой грамотности через игры и персонализированный подход. Приложение адаптирует контент под возраст и интересы ребенка.

## 🎮 Основные экраны приложения

<table>
<tr>
<td width="40%">
<img src="https://github.com/user-attachments/assets/6ab13336-71b9-4782-86f7-999132412525" width="300">
</td>
<td width="60%">

### Сплэш-скрин
- Анимация появления маскота

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/f8a39b1a-bf60-401f-9811-3e8788a630c5" width="300">
</td>
<td>


### 1. Главный экран
- Чат с маскотом (персональным помощником)
- Быстрый доступ к играм:
  - «Покупки»
  - «Карточки»
- Переход в профиль пользователя
- Добавлена анимация лопания пузырьков по нажатию пльзователя

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/6e5ebb22-9044-473f-9464-8b2ffb037d60" width="300">
<td>

### 2. Чат с маскотом
- Персонализированное общение (по имени, возрасту и интересам)
- Обучение финансовым понятиям в диалоговой форме
- Подсказки по управлению карманными деньгами

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/5e977763-430e-4718-9174-958c0709686d" width="300">
</td>
<td>

### 3. Игра «Карточки»
- Карточки с различными товарами
- Задача — угадать реальную стоимость
- Обучение пониманию ценности вещей

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/c4fd07df-5c8f-42d4-95ea-5be18a188c0d" width="300">
</td>
<td>

### 4. Игра «Покупки»
- Сбор продуктовой корзины в рамках бюджета
- Обучение планированию расходов
- Развитие навыков осознанного потребления

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/2744f59a-fde7-492e-94d7-7c087363a092" width="300">
</td>
<td>

### 5. Профиль пользователя
- Настройка аватарки (фото или иконка)
- Указание имени, возраста и хобби
- Персонализация общения с маскотом

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/281528fb-8104-4ac3-b212-f84e8ae0d044" width="300">
</td>
<td>

### 6. Экран целей
- Создание финансовых целей
- Указание суммы и приоритета
- Отслеживание прогресса накоплений

</td>
</tr>

<tr>
<td>
<img src="https://github.com/user-attachments/assets/6ed45bc6-d9be-4b50-9d8d-68565e7308f1" width="300">
</td>
<td>

### 7. Аналитика расходов
- Визуализация расходов в виде диаграмм
- Загрузка банковской выписки
- Ручное добавление трат

</td>
</tr>
</table>

## 👥 Распределение ролей в команде

| Имя   | Разработанные экраны | Имена файлов      |
|-------|--------------------|---------------------------------|
| Аня   | Главный экран, Экран аналитики, Дизайн | HomeView.swift, BubbleAnimationView.swift, AnalyticsView.swift, AnalyticsViewModel.swift, Plot.swift, PdfDocumentPicker.swift |
| Егор  | Профиль, SplashScreen | SplashScreen.swift; AvatarPickerView.swift; EditableField.swift; ProfileSettingsView.swift; SettingsButtonStyle.swift; UserSettingsManager.swift |
| Тагир |  |   |
| Данил | Модуль чата, интеграция swiftData, интеграция с ИИ сервисом| ChatScreen, ChatViewModel, Modifiers |
| Миша  |  |  |
| Марго | Игра Карточки, DI, Tests | ScreenFactory.swift; Storage.swift; CardGameRound.swift; CardGameViewModel.swift; CardGameView.swift; CardView.swift; CardGameViewModelTests.swift; FintechKidsUITests.swift

## 🔌 Настройка API ключа для работы моделей в приложении

Для работы интеллектуального чат-бота с маскотом и системы аналитики трат необходимо настроить API ключ:

### 📌 Инструкция по настройке:

1. **Получение API ключа**

   🔹 Перейдите на [OpenRouter.ai](https://openrouter.ai/models?max_price=0)

   🔹 Авторизуйтесь/зарегистрируйтесь

   🔹 Включите "Model Training" на странице [настроек Privacy](https://openrouter.ai/settings/privacy)

   🔹 В разделе профиля выберите **"Keys"**

   🔹 Нажмите **"Create key"**

   🔹 В поле `Name` укажите любое название (например: "FintechKids_Prod")

   🔹 Поле `Credit limit` оставьте **пустым**

   🔹 Скопируйте сгенерированный ключ

2. **Установка ключа в проекте**
   Откройте файл:  FintechKids/FintechKids/Networking/LLMKeyProvider.swift
   Найдите строку:
   ```swift
   case apiKey = "..."
   ```

3. **Замените значение между кавычек на ваш ключ:**
   ```swift
   case apiKey = "ВАШ_НОВЫЙ_КЛЮЧ_ЗДЕСЬ"
   ```

4. Работоспособность сервиса может зависеть от сетевых настроек (VPN, локации IP-адреса)

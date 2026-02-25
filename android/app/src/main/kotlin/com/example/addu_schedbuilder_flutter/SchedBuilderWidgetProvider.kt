package com.example.addu_schedbuilder_flutter

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class SchedBuilderWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(
                context.packageName,
                R.layout.widget_layout
            ).apply {
                val widgetData = HomeWidgetPlugin.getData(context)

                // Set title (day name)
                val title = widgetData.getString("widget_title", "SchedBuilder")
                setTextViewText(R.id.widget_title, title)

                // Set message (class count or no classes)
                val message = widgetData.getString("widget_message", "No schedule set")
                setTextViewText(R.id.widget_message, message)

                // Get class count
                val classCount = widgetData.getInt("class_count", 0)

                if (classCount > 0) {
                    // Show first class
                    val subject = widgetData.getString("class_0_subject", "")
                    val code = widgetData.getString("class_0_code", "")
                    val time = widgetData.getString("class_0_time", "")
                    val room = widgetData.getString("class_0_room", "")

                    setTextViewText(R.id.class_0_subject, subject)
                    setTextViewText(R.id.class_0_code, code)
                    setTextViewText(R.id.class_0_time, time)
                    setTextViewText(R.id.class_0_room, "Room: $room")

                    setViewVisibility(R.id.class_0_container, android.view.View.VISIBLE)

                    // Show second class if exists
                    if (classCount > 1) {
                        val subject1 = widgetData.getString("class_1_subject", "")
                        val code1 = widgetData.getString("class_1_code", "")
                        val time1 = widgetData.getString("class_1_time", "")
                        val room1 = widgetData.getString("class_1_room", "")

                        setTextViewText(R.id.class_1_subject, subject1)
                        setTextViewText(R.id.class_1_code, code1)
                        setTextViewText(R.id.class_1_time, time1)
                        setTextViewText(R.id.class_1_room, "Room: $room1")

                        setViewVisibility(R.id.class_1_container, android.view.View.VISIBLE)
                    } else {
                        setViewVisibility(R.id.class_1_container, android.view.View.GONE)
                    }

                    // Show third class if exists
                    if (classCount > 2) {
                        val subject2 = widgetData.getString("class_2_subject", "")
                        val code2 = widgetData.getString("class_2_code", "")
                        val time2 = widgetData.getString("class_2_time", "")
                        val room2 = widgetData.getString("class_2_room", "")

                        setTextViewText(R.id.class_2_subject, subject2)
                        setTextViewText(R.id.class_2_code, code2)
                        setTextViewText(R.id.class_2_time, time2)
                        setTextViewText(R.id.class_2_room, "Room: $room2")

                        setViewVisibility(R.id.class_2_container, android.view.View.VISIBLE)
                    } else {
                        setViewVisibility(R.id.class_2_container, android.view.View.GONE)
                    }

                    setViewVisibility(R.id.empty_state, android.view.View.GONE)
                } else {
                    // Hide all class containers
                    setViewVisibility(R.id.class_0_container, android.view.View.GONE)
                    setViewVisibility(R.id.class_1_container, android.view.View.GONE)
                    setViewVisibility(R.id.class_2_container, android.view.View.GONE)
                    setViewVisibility(R.id.empty_state, android.view.View.VISIBLE)
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

---
description: Use when working with BPMN 2.0 XML files (.bpmn) — generates, reads, updates, and validates diagrams compatible with Camunda, Bizagi, and Signavio. Triggers on ".bpmn file", "BPMN diagram", "process diagram XML", "validate BPMN".
---

# /bpmn — BPMN 2.0 File Operations

## Purpose

Generate, read, update, and validate BPMN 2.0 XML files (.bpmn). These files are compatible with standard BPMN tools like Camunda Modeler, Bizagi, Signavio, and other BPMN 2.0 compliant software.

## When to Use

- Creating new .bpmn files from process descriptions
- Reading and explaining existing .bpmn files
- Modifying elements in existing .bpmn diagrams
- Converting forge artifacts (event storms, event models) to BPMN format
- Validating .bpmn files for correctness

## Capabilities

### 1. Generate — Create New .bpmn Files

```
/bpmn Create order-fulfillment.bpmn for: Customer places order,
warehouse picks items, shipping delivers to customer
```

### 2. Read — Explain Existing .bpmn Files

```
/bpmn Read and explain processes/checkout.bpmn
```

### 3. Update — Modify Existing .bpmn Files

```
/bpmn Add error handling to the "Process Payment" task in checkout.bpmn
```

```
/bpmn Expand "Fulfill Order" into a subprocess with pick, pack, ship steps
```

### 4. Convert — Transform Other Artifacts

```
/bpmn Convert the event storm output to a .bpmn file
```

### 5. Validate — Check .bpmn File Correctness

```
/bpmn Validate order-process.bpmn
```

## BPMN 2.0 XML Structure

When generating .bpmn files, use this structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<bpmn:definitions
    xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL"
    xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI"
    xmlns:dc="http://www.omg.org/spec/DD/20100524/DC"
    xmlns:di="http://www.omg.org/spec/DD/20100524/DI"
    id="Definitions_1"
    targetNamespace="http://bpmn.io/schema/bpmn">

    <!-- Process Definition -->
    <bpmn:process id="Process_1" name="Process Name" isExecutable="true">
        <!-- Elements go here -->
    </bpmn:process>

    <!-- Diagram Information (for visual layout) -->
    <bpmndi:BPMNDiagram id="BPMNDiagram_1">
        <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1">
            <!-- Shape and edge definitions for layout -->
        </bpmndi:BPMNPlane>
    </bpmndi:BPMNDiagram>

</bpmn:definitions>
```

## BPMN Element Reference

### Events

```xml
<!-- Start Event -->
<bpmn:startEvent id="StartEvent_1" name="Order Received">
    <bpmn:outgoing>Flow_1</bpmn:outgoing>
</bpmn:startEvent>

<!-- End Event -->
<bpmn:endEvent id="EndEvent_1" name="Process Complete">
    <bpmn:incoming>Flow_N</bpmn:incoming>
</bpmn:endEvent>

<!-- Timer Start Event -->
<bpmn:startEvent id="TimerStart_1" name="Daily at 9am">
    <bpmn:timerEventDefinition>
        <bpmn:timeCycle>0 9 * * *</bpmn:timeCycle>
    </bpmn:timerEventDefinition>
    <bpmn:outgoing>Flow_1</bpmn:outgoing>
</bpmn:startEvent>

<!-- Message Start Event -->
<bpmn:startEvent id="MessageStart_1" name="Order Message">
    <bpmn:messageEventDefinition messageRef="Message_Order"/>
    <bpmn:outgoing>Flow_1</bpmn:outgoing>
</bpmn:startEvent>

<!-- Intermediate Timer Event -->
<bpmn:intermediateCatchEvent id="Timer_1" name="Wait 24 hours">
    <bpmn:incoming>Flow_X</bpmn:incoming>
    <bpmn:outgoing>Flow_Y</bpmn:outgoing>
    <bpmn:timerEventDefinition>
        <bpmn:timeDuration>PT24H</bpmn:timeDuration>
    </bpmn:timerEventDefinition>
</bpmn:intermediateCatchEvent>

<!-- Error End Event -->
<bpmn:endEvent id="ErrorEnd_1" name="Process Failed">
    <bpmn:incoming>Flow_Error</bpmn:incoming>
    <bpmn:errorEventDefinition errorRef="Error_1"/>
</bpmn:endEvent>

<!-- Boundary Error Event -->
<bpmn:boundaryEvent id="BoundaryError_1" attachedToRef="Task_1">
    <bpmn:outgoing>Flow_ErrorPath</bpmn:outgoing>
    <bpmn:errorEventDefinition errorRef="Error_Payment"/>
</bpmn:boundaryEvent>
```

### Activities

```xml
<!-- User Task -->
<bpmn:userTask id="Task_Review" name="Review Application">
    <bpmn:incoming>Flow_1</bpmn:incoming>
    <bpmn:outgoing>Flow_2</bpmn:outgoing>
</bpmn:userTask>

<!-- Service Task -->
<bpmn:serviceTask id="Task_SendEmail" name="Send Confirmation Email">
    <bpmn:incoming>Flow_2</bpmn:incoming>
    <bpmn:outgoing>Flow_3</bpmn:outgoing>
</bpmn:serviceTask>

<!-- Manual Task -->
<bpmn:manualTask id="Task_Pack" name="Pack Items">
    <bpmn:incoming>Flow_3</bpmn:incoming>
    <bpmn:outgoing>Flow_4</bpmn:outgoing>
</bpmn:manualTask>

<!-- Script Task -->
<bpmn:scriptTask id="Task_Calculate" name="Calculate Total" scriptFormat="javascript">
    <bpmn:script>var total = items.reduce((sum, i) => sum + i.price, 0);</bpmn:script>
    <bpmn:incoming>Flow_4</bpmn:incoming>
    <bpmn:outgoing>Flow_5</bpmn:outgoing>
</bpmn:scriptTask>

<!-- Call Activity (reusable subprocess) -->
<bpmn:callActivity id="Call_Shipping" name="Shipping Process" calledElement="ShippingProcess">
    <bpmn:incoming>Flow_5</bpmn:incoming>
    <bpmn:outgoing>Flow_6</bpmn:outgoing>
</bpmn:callActivity>

<!-- Subprocess (embedded) -->
<bpmn:subProcess id="SubProcess_Fulfillment" name="Order Fulfillment">
    <bpmn:incoming>Flow_In</bpmn:incoming>
    <bpmn:outgoing>Flow_Out</bpmn:outgoing>
    <bpmn:startEvent id="SubStart_1"/>
    <!-- subprocess contents -->
    <bpmn:endEvent id="SubEnd_1"/>
</bpmn:subProcess>
```

### Gateways

```xml
<!-- Exclusive Gateway (XOR) - one path -->
<bpmn:exclusiveGateway id="Gateway_Decision" name="Approved?">
    <bpmn:incoming>Flow_1</bpmn:incoming>
    <bpmn:outgoing>Flow_Yes</bpmn:outgoing>
    <bpmn:outgoing>Flow_No</bpmn:outgoing>
</bpmn:exclusiveGateway>

<!-- Parallel Gateway (AND) - all paths -->
<bpmn:parallelGateway id="Gateway_Fork" name="Fork">
    <bpmn:incoming>Flow_1</bpmn:incoming>
    <bpmn:outgoing>Flow_Branch1</bpmn:outgoing>
    <bpmn:outgoing>Flow_Branch2</bpmn:outgoing>
</bpmn:parallelGateway>

<!-- Inclusive Gateway (OR) - one or more paths -->
<bpmn:inclusiveGateway id="Gateway_Options" name="Select Options">
    <bpmn:incoming>Flow_1</bpmn:incoming>
    <bpmn:outgoing>Flow_Option1</bpmn:outgoing>
    <bpmn:outgoing>Flow_Option2</bpmn:outgoing>
</bpmn:inclusiveGateway>

<!-- Event-Based Gateway -->
<bpmn:eventBasedGateway id="Gateway_Wait" name="Wait for Response">
    <bpmn:incoming>Flow_1</bpmn:incoming>
    <bpmn:outgoing>Flow_Message</bpmn:outgoing>
    <bpmn:outgoing>Flow_Timeout</bpmn:outgoing>
</bpmn:eventBasedGateway>
```

### Sequence Flows

```xml
<!-- Basic flow -->
<bpmn:sequenceFlow id="Flow_1" sourceRef="StartEvent_1" targetRef="Task_1"/>

<!-- Conditional flow (from gateway) -->
<bpmn:sequenceFlow id="Flow_Yes" name="Yes" sourceRef="Gateway_1" targetRef="Task_Approve">
    <bpmn:conditionExpression xsi:type="bpmn:tFormalExpression">
        ${approved == true}
    </bpmn:conditionExpression>
</bpmn:sequenceFlow>

<!-- Default flow -->
<bpmn:sequenceFlow id="Flow_Default" sourceRef="Gateway_1" targetRef="Task_Reject">
    <bpmn:conditionExpression xsi:type="bpmn:tFormalExpression"/>
</bpmn:sequenceFlow>
```

### Participants and Lanes

```xml
<!-- Collaboration with pools -->
<bpmn:collaboration id="Collaboration_1">
    <bpmn:participant id="Participant_Company" name="Company" processRef="Process_1"/>
    <bpmn:participant id="Participant_Customer" name="Customer" processRef="Process_2"/>
    <bpmn:messageFlow id="MsgFlow_1" sourceRef="Task_Send" targetRef="Task_Receive"/>
</bpmn:collaboration>

<!-- Lanes within a process -->
<bpmn:process id="Process_1">
    <bpmn:laneSet id="LaneSet_1">
        <bpmn:lane id="Lane_Sales" name="Sales Team">
            <bpmn:flowNodeRef>Task_1</bpmn:flowNodeRef>
            <bpmn:flowNodeRef>Task_2</bpmn:flowNodeRef>
        </bpmn:lane>
        <bpmn:lane id="Lane_Warehouse" name="Warehouse">
            <bpmn:flowNodeRef>Task_3</bpmn:flowNodeRef>
        </bpmn:lane>
    </bpmn:laneSet>
    <!-- tasks and flows -->
</bpmn:process>
```

### Data Objects

```xml
<!-- Data Object -->
<bpmn:dataObject id="DataObject_Order" name="Order"/>

<!-- Data Object Reference -->
<bpmn:dataObjectReference id="DataRef_Order" name="Order Data" dataObjectRef="DataObject_Order"/>

<!-- Data Input/Output on tasks -->
<bpmn:userTask id="Task_1" name="Review Order">
    <bpmn:dataInputAssociation id="Input_1">
        <bpmn:sourceRef>DataRef_Order</bpmn:sourceRef>
    </bpmn:dataInputAssociation>
</bpmn:userTask>
```

## Diagram Layout (BPMNDi)

Always include diagram information for visual rendering:

```xml
<bpmndi:BPMNDiagram id="BPMNDiagram_1">
    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1">

        <!-- Shape for Start Event -->
        <bpmndi:BPMNShape id="StartEvent_1_di" bpmnElement="StartEvent_1">
            <dc:Bounds x="180" y="100" width="36" height="36"/>
        </bpmndi:BPMNShape>

        <!-- Shape for Task -->
        <bpmndi:BPMNShape id="Task_1_di" bpmnElement="Task_1">
            <dc:Bounds x="270" y="78" width="100" height="80"/>
        </bpmndi:BPMNShape>

        <!-- Shape for Gateway -->
        <bpmndi:BPMNShape id="Gateway_1_di" bpmnElement="Gateway_1" isMarkerVisible="true">
            <dc:Bounds x="420" y="93" width="50" height="50"/>
        </bpmndi:BPMNShape>

        <!-- Edge for Sequence Flow -->
        <bpmndi:BPMNEdge id="Flow_1_di" bpmnElement="Flow_1">
            <di:waypoint x="216" y="118"/>
            <di:waypoint x="270" y="118"/>
        </bpmndi:BPMNEdge>

    </bpmndi:BPMNPlane>
</bpmndi:BPMNDiagram>
```

## Layout Guidelines

When generating diagram coordinates:

1. **Horizontal flow**: Start at x=180, increment by ~150 for each element
2. **Task dimensions**: width="100" height="80"
3. **Event dimensions**: width="36" height="36"
4. **Gateway dimensions**: width="50" height="50"
5. **Vertical spacing for branches**: increment y by ~100 for parallel paths
6. **Lane height**: ~200 per lane
7. **Pool width**: sum of all element widths + margins

## File Naming Convention

```
[domain]-[process-name].bpmn

Examples:
- order-fulfillment.bpmn
- customer-onboarding.bpmn
- payment-processing.bpmn
- employee-offboarding.bpmn
```

## Validation Checks

When validating .bpmn files, check for:

1. **Start Event**: At least one per process
2. **End Event**: All paths must reach an end event
3. **Gateway Balance**: Splits should have corresponding joins
4. **Flow Connectivity**: No orphaned elements
5. **ID Uniqueness**: All IDs must be unique within the file
6. **Reference Integrity**: All refs point to existing elements
7. **Lane Assignment**: All flow nodes should be in lanes (if lanes exist)

## Integration with /workflow

The `/workflow` command uses this skill to:

1. Generate initial .bpmn file after Phase 2 (happy path)
2. Update the file as decisions and exceptions are discovered
3. Create subprocess .bpmn files for expanded steps
4. Read back the current state to continue refinement

## Example Output

```xml
<?xml version="1.0" encoding="UTF-8"?>
<bpmn:definitions
    xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL"
    xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI"
    xmlns:dc="http://www.omg.org/spec/DD/20100524/DC"
    xmlns:di="http://www.omg.org/spec/DD/20100524/DI"
    id="Definitions_OrderFulfillment"
    targetNamespace="http://example.com/bpmn">

    <bpmn:process id="Process_OrderFulfillment" name="Order Fulfillment" isExecutable="true">

        <bpmn:startEvent id="Start_OrderReceived" name="Order Received">
            <bpmn:outgoing>Flow_1</bpmn:outgoing>
        </bpmn:startEvent>

        <bpmn:userTask id="Task_ValidateOrder" name="Validate Order">
            <bpmn:incoming>Flow_1</bpmn:incoming>
            <bpmn:outgoing>Flow_2</bpmn:outgoing>
        </bpmn:userTask>

        <bpmn:exclusiveGateway id="Gateway_StockCheck" name="In Stock?">
            <bpmn:incoming>Flow_2</bpmn:incoming>
            <bpmn:outgoing>Flow_Yes</bpmn:outgoing>
            <bpmn:outgoing>Flow_No</bpmn:outgoing>
        </bpmn:exclusiveGateway>

        <bpmn:manualTask id="Task_PickItems" name="Pick Items">
            <bpmn:incoming>Flow_Yes</bpmn:incoming>
            <bpmn:outgoing>Flow_3</bpmn:outgoing>
        </bpmn:manualTask>

        <bpmn:serviceTask id="Task_CreateBackorder" name="Create Backorder">
            <bpmn:incoming>Flow_No</bpmn:incoming>
            <bpmn:outgoing>Flow_4</bpmn:outgoing>
        </bpmn:serviceTask>

        <bpmn:manualTask id="Task_PackOrder" name="Pack Order">
            <bpmn:incoming>Flow_3</bpmn:incoming>
            <bpmn:outgoing>Flow_5</bpmn:outgoing>
        </bpmn:manualTask>

        <bpmn:serviceTask id="Task_Ship" name="Ship to Customer">
            <bpmn:incoming>Flow_5</bpmn:incoming>
            <bpmn:outgoing>Flow_6</bpmn:outgoing>
        </bpmn:serviceTask>

        <bpmn:endEvent id="End_OrderComplete" name="Order Fulfilled">
            <bpmn:incoming>Flow_6</bpmn:incoming>
        </bpmn:endEvent>

        <bpmn:endEvent id="End_Backordered" name="Order Backordered">
            <bpmn:incoming>Flow_4</bpmn:incoming>
        </bpmn:endEvent>

        <bpmn:sequenceFlow id="Flow_1" sourceRef="Start_OrderReceived" targetRef="Task_ValidateOrder"/>
        <bpmn:sequenceFlow id="Flow_2" sourceRef="Task_ValidateOrder" targetRef="Gateway_StockCheck"/>
        <bpmn:sequenceFlow id="Flow_Yes" name="Yes" sourceRef="Gateway_StockCheck" targetRef="Task_PickItems"/>
        <bpmn:sequenceFlow id="Flow_No" name="No" sourceRef="Gateway_StockCheck" targetRef="Task_CreateBackorder"/>
        <bpmn:sequenceFlow id="Flow_3" sourceRef="Task_PickItems" targetRef="Task_PackOrder"/>
        <bpmn:sequenceFlow id="Flow_4" sourceRef="Task_CreateBackorder" targetRef="End_Backordered"/>
        <bpmn:sequenceFlow id="Flow_5" sourceRef="Task_PackOrder" targetRef="Task_Ship"/>
        <bpmn:sequenceFlow id="Flow_6" sourceRef="Task_Ship" targetRef="End_OrderComplete"/>

    </bpmn:process>

    <bpmndi:BPMNDiagram id="BPMNDiagram_1">
        <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_OrderFulfillment">
            <bpmndi:BPMNShape id="Start_di" bpmnElement="Start_OrderReceived">
                <dc:Bounds x="180" y="100" width="36" height="36"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="Task_Validate_di" bpmnElement="Task_ValidateOrder">
                <dc:Bounds x="270" y="78" width="100" height="80"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="Gateway_di" bpmnElement="Gateway_StockCheck" isMarkerVisible="true">
                <dc:Bounds x="420" y="93" width="50" height="50"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="Task_Pick_di" bpmnElement="Task_PickItems">
                <dc:Bounds x="520" y="78" width="100" height="80"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="Task_Backorder_di" bpmnElement="Task_CreateBackorder">
                <dc:Bounds x="520" y="200" width="100" height="80"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="Task_Pack_di" bpmnElement="Task_PackOrder">
                <dc:Bounds x="670" y="78" width="100" height="80"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="Task_Ship_di" bpmnElement="Task_Ship">
                <dc:Bounds x="820" y="78" width="100" height="80"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="End_Complete_di" bpmnElement="End_OrderComplete">
                <dc:Bounds x="972" y="100" width="36" height="36"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNShape id="End_Backorder_di" bpmnElement="End_Backordered">
                <dc:Bounds x="672" y="222" width="36" height="36"/>
            </bpmndi:BPMNShape>
            <bpmndi:BPMNEdge id="Flow_1_di" bpmnElement="Flow_1">
                <di:waypoint x="216" y="118"/>
                <di:waypoint x="270" y="118"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_2_di" bpmnElement="Flow_2">
                <di:waypoint x="370" y="118"/>
                <di:waypoint x="420" y="118"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_Yes_di" bpmnElement="Flow_Yes">
                <di:waypoint x="470" y="118"/>
                <di:waypoint x="520" y="118"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_No_di" bpmnElement="Flow_No">
                <di:waypoint x="445" y="143"/>
                <di:waypoint x="445" y="240"/>
                <di:waypoint x="520" y="240"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_3_di" bpmnElement="Flow_3">
                <di:waypoint x="620" y="118"/>
                <di:waypoint x="670" y="118"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_4_di" bpmnElement="Flow_4">
                <di:waypoint x="620" y="240"/>
                <di:waypoint x="672" y="240"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_5_di" bpmnElement="Flow_5">
                <di:waypoint x="770" y="118"/>
                <di:waypoint x="820" y="118"/>
            </bpmndi:BPMNEdge>
            <bpmndi:BPMNEdge id="Flow_6_di" bpmnElement="Flow_6">
                <di:waypoint x="920" y="118"/>
                <di:waypoint x="972" y="118"/>
            </bpmndi:BPMNEdge>
        </bpmndi:BPMNPlane>
    </bpmndi:BPMNDiagram>

</bpmn:definitions>
```
